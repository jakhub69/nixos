{ config, lib, pkgs, ... }:
{
# Usługi
  services = {
    xserver.enable = false;       # Włącz sesję X11. Wyłącz by zostawić tylko Wayland
    passSecretService.package = pkgs.libsecret; # Wsparcie dla menedżera haseł, wymagane do niektórych programów
    passSecretService.enable = true;  # Włącz wsparcie dla menedżera haseł
    envfs.enable = true;              # Wsparcie dla envfs, wymagane do niektórych programów

    # Wysoki priorytet gier dzięki ananicy od cachyos. Gryzie się z scx_lavd
    ananicy = {
      enable = false;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    # Lokalny dyrygent/scheduler który podobno polepsza działanie komputera w stresie
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };


    xserver.xkb = { # Polska klawiatura
      layout = "pl";
      variant = "";
    };

    udev.packages = with pkgs; [
      game-devices-udev-rules
    ];

    # Zasady udev bym mógł konfigurować mysz i klawiaturę w programie, pierwsze dwie to mchose a7 v2 ultra, trzecia to akko mod 008
    #udev.extraRules = ''
    #KERNEL=="hidraw*", ATTRS{idVendor}=="3837", ATTRS{idProduct}=="100b", MODE="0666", TAG+="uaccess"
    #KERNEL=="hidraw*", ATTRS{idVendor}=="3837", ATTRS{idProduct}=="4019", MODE="0666", TAG+="uaccess"
    #KERNEL=="hidraw*", ATTRS{idVendor}=="3151", ATTRS{idProduct}=="4002", MODE="0666", TAG+="uaccess"
    #'';


    displayManager = {
      sddm.enable = true; # SDDM Plasma login manager
      sddm.wayland.enable = true; # Włącz SDDM w trybie Wayland
      defaultSession = "plasma";  # Plasma-wayland jako default lub plasmax11 dla x11
    };
    desktopManager.plasma6.enable = true; # Plasma 6

    printing.enable = false; # Wsparcie drukarek

    libinput.enable = false; # Wsparcie touchpadów
  };

}
