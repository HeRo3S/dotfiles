{ config, lib, pkgs, ... }:

{
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      wireplumber = { enable = true; };
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      socketActivation = true;
    };
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
    alsa-lib
    libjack2
    jack2
    jack_capture
    pavucontrol
    helvum
  ];
}
