#!/bin/bash

script_dir=$(dirname "$(realpath "$0")")
parent_dir=$(dirname "$script_dir")

read -r -p "Typing username: " USERNAME
GROUPNAME="wheel"

groupadd "$GROUPNAME"
useradd -m -s /bin/bash -G "$GROUPNAME" "$USERNAME"

# Set the user's password (optional)
echo "$USERNAME:password" | chpasswd

# Add sudoers privileges to the group
mkdir /etc/sudoers.d/
touch /etc/sudoers.d/"$GROUPNAME"
echo "%$GROUPNAME ALL=(ALL) ALL" | tee /etc/sudoers.d/"$GROUPNAME"

# Move the script repository to the new user's home directory
mv "$parent_dir" /home/"$USERNAME"/

# Change ownership of the script repository to the new user
chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/"$(basename "$parent_dir")"

su - "$USERNAME"
