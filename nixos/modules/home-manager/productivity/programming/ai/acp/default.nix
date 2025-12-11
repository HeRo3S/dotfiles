{ config, pkgs, ... }: {
  imports = [ ./qwen-code ];
  home.packages = with pkgs; [ opencode ];
  home.file = {
    ".config/opencode/opencode.json".source =
      config.lib.file.mkOutOfStoreSymlink
      ("${config.customVars.dotfilesDir}/.config/opencode/opencode.json");
  };
}
