{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedTCPPortRanges = [{
    from = 3000;
    to = 3010;
  }];
  # networking.firewall.allowedUDPPortRanges = [{
  #   from = 4000;
  #   to = 4007;
  # }];

  # networking.networkmanager.dns = "none";
  # services.resolved.enable = true;

  # Direct Quad9 DNS servers
  # networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];

  hardware.bluetooth = lib.mkIf config.customCfg.isLaptop {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      experimental = true; # show battery
      # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
      # for pairing bluetooth controller
      Privacy = "device";
      JustWorksRepairing = "always";
      Class = "0x000100";
      FastConnectable = true;
    };
  };
  boot.extraModprobeConfig =
    lib.mkIf config.customCfg.isLaptop "options btusb enable_autosuspend=0";
  services.blueman.enable = lib.mkIf config.customCfg.isLaptop true;

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
