{...}:
{
    programs.git = {
        enable = true;
        userName = "HeRo3S";
        userEmail = "hungid6a1@gmail.com";
        extraConfig = {
            init = { defaultBranch = "main"; };
            core = {
                excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
            };
        };
    };

    programs.gh = {
        enable = true;
    }
}
