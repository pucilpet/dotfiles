{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Imports nvidia ext display to grub
    ./Nvidia.nix

    # Shared configuration across all machines
    ../shared
  ];

  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Make modules available to modprobe
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];

    #add ntfs support
    supportedFilesystems = ["ntfs"];
    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["btrfs"];
    };

    # Load modules on boot
    kernelModules = ["acpi_call"];

    # Kernel parameters
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = true;
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
  location.latitude = 62.897968;
  location.longitude = 27.678171;

  services = {
    btrfs.autoScrub.enable = true;
    acpid.enable = true;
    #add tailscale
    tailscale.enable = true;

    thermald.enable = true;
    upower.enable = true;
    # redshift config
    redshift = {
      enable = true;
      brightness = {
        # Note the string values below.
        day = "1";
        night = "0.8";
      };
      temperature = {
        day = 5500;
        night = 3700;
      };
    };

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0; # dummy value
        STOP_CHARGE_THRESH_BAT0 = 1; # battery conservation mode
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };
  };

  environment = {
    variables = {
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };

    systemPackages = with pkgs; [
      acpi
      alsa-lib
      alsa-plugins
      alsa-tools
      alsa-utils
      arandr
      blueberry
      brightnessctl
      gcc
      libva
      libva-utils
      ocl-icd
      pamixer
      pavucontrol
      pulseaudio
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      nextcloud-client
      onlyoffice-bin
      element-desktop
      gimp
      imagemagick
      borgbackup
      unzip
      feh
      scrcpy
      gotop
      spotify
      flameshot
      xfce.thunar
      xfce.xfce4-power-manager
      syncthing
    ];
  };

  modules.nixos = {
    bootloader.grub = {
      enable = true;
      efiSysMountPoint = "/boot";
      device = "nodev";
    };

    hardware.nvidia-offload.enable = true;
    hardware.nvidia-sync.enable = false;

    virtualisation = {
      docker = {
        enable = true;
        enableNvidia = true;
      };

      libvirtd.enable = true;

      podman = {
        enable = true;
        enableNvidia = true;
      };
    };

    windowManager.awesome = {
      enable = true;
      layout = "us";
    };
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
