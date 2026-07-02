{ config, lib, pkgs, ... }:

{
# Sprzęt
  hardware = {
    xpadneo.enable = true;            # Włącz wsparcie bluetooth do padów xboxowych
    xone.enable = true;              # Włącz wsparcie xboxowego dongla usb, nie można łączyć z xpadneo
    steam-hardware.enable = true;     # Włącz wsparcie dla kontrolerów steamowych + Valve index

    #amdgpu = {
    #  opencl.enable = true;      # Włącz OpenCL dla AMD GPU
    #  overdrive.enable = true;   # Pozwól na Overclock potrzebny przez program LACT
    #};

    nvidia = {
      modesetting.enable = true;      # Kluczowe dla poprawnego działania Waylanda i odświeżania
      powerManagement.enable = false; # Wyłączone zarządzanie zasilaniem (zapobiega lagom/problemom po uśpieniu)
      powerManagement.finegrained = false;
      open = true;                    # Użyj nowych, otwartych modułów jądra (rekomendowane i stabilne dla serii RTX 40xx)
      nvidiaSettings = true;          # Włącz panel kontrolny nvidia-settings
      package = config.boot.kernelPackages.nvidiaPackages.stable; # Stabilna wersja sterownika
    };

    graphics = {
        enable = true;                # Aktywuj akcelerację w aplikacjach 64 bitowych
        enable32Bit = true;           # Aktywuj akcelerację w aplikacjach 32 bitowych
    };

    bluetooth = { # Ja nie mam bluetooth, to po co włączać
      enable = false;
      powerOnBoot = true;
    };

    uinput.enable = true;             # Włącza tworzenie wirtualnych urządzeń, użyteczne do makro
  };

  # Dodaj wsparcie podpinania pendrive (LOL)
  services = {
    xserver.videoDrivers = [ "nvidia" ]; # Wymuś ładowanie sterownika NVIDIA w systemie
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };

  services.fstrim.enable = true; # Włącz trim dla SSD

  # Aktywuj wirtualizację dla virt managera
  virtualisation = {
    waydroid.enable = true;     # Android na linuxie
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker.enable = false;
    podman.enable = false; # Do distrobox
    podman.dockerCompat = false;
  };
}
