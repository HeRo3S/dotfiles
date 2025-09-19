{ config, lib, pkgs, ... }:

{
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # networking.networkmanager.dns = "none";
  # services.resolved.enable = true;
  
  # Direct Quad9 DNS servers
  # networking.nameservers = [ "9.9.9.9" "149.112.112.112" ];

  hardware.bluetooth.enable = lib.mkIf config.customCfg.bluetooth.enable true;
  services.blueman.enable = lib.mkIf config.customCfg.bluetooth.enable true;

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
