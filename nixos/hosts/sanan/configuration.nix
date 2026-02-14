# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    inputs.home-manager.nixosModules.default
  ];

  ## Custom config
  customCfg = {
    graphics = {
      nvidia = {
        enable = false;
        discreteGpuBusId = "PCI:1@0:0:0";
        onboardGpuBusId = "PCI:0@0:2:0";
      };
      intel = {
        enable = true;
        isLegacyDevice = false;
      };
      amd = {
        enable = false;
      };
    };
    bluetooth.enable = true;
    isLaptop = false;
    vfio = {
      enable = false;
      vfioPciDevices = [ "10de:1f91" "10de:10fa" ];
    };
    containers = {
      docker = true;
      podman = true;
    };
    user = { name = "amelia"; };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      # layout = "us";
      # variant = "";
      layout = "us,us";
      variant = ",colemak_dh";
      options = "grp:win_space_toggle";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${config.customCfg.user.name} = {
    isNormalUser = true;
    description = config.customCfg.user.name;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };
  security.pam.loginLimits = [{
    domain = "*";
    type = "-";
    item = "memlock";
    value = "infinity";
  }];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
    users = { ${config.customCfg.user.name} = import ./home.nix; };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
