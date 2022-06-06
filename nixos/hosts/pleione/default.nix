# System configuration for my laptop
{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ../../common/global
    ../../common/optional/misterio-greetd.nix
    ../../common/optional/pipewire.nix
    ../../common/optional/podman.nix
    ../../common/optional/postgres.nix
    ../../common/optional/quietboot.nix
    ../../common/optional/steam.nix
    ../../common/optional/systemd-boot.nix
    ../../common/optional/tailscale.nix
  ];


  networking.networkmanager.enable = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_18;

  services.dbus.packages = [ pkgs.gcr ];

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    gamemode.enable = true;
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  # Lid settings
  services.logind ={
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    wlr.enable = true;
  };

  system.stateVersion = "22.05";
}
