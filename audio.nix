{ config, lib, pkgs, ... }:

{
  security.rtkit.enable = true; # Zezwól na audio w priorytecie realtime

  services = {
    pulseaudio.enable = false; # Systemowy pulseaudio wyłączony na rzecz pipewire

    pipewire = { # Włącz pipewire
      enable = true;
      alsa.enable = true; # Włącz emulację ALSA
      alsa.support32Bit = true; # Wsparcie dla 32-bitowych bibliotek (np. Steam)
      pulse.enable = true; # Włącz emulację Pulseaudio
    };
  };
}
