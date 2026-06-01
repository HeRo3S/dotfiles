let
  hero3s_github =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINoYYyrJ5+ihFd8XyweEeC/ADHuCoR9yaOqNzDNZP2un hungid6a1@gmail.com";
  users = [ hero3s_github ];

in { "steamAPI.age".publicKeys = users; }
