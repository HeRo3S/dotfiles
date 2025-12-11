{ pkgs, ... }: {
  imports = [ ./qwen-code ];
  home.packages = with pkgs; [ opencode ];
}
