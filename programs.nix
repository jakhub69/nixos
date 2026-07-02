{ config, lib, pkgs, ... }:

{
# Programy zainstalowane dla wszystkich użytkowników, które nie posiadają modułów wbudowanych w nix (sekcja programs)
  environment.systemPackages = with pkgs; [
  
  ## System
  papirus-icon-theme                    # Ikony systemowe
  qdirstat                              # Analiza dysków
  fastfetch                             # Informacje o systemie w terminalu
  gparted                               # Partycjonowanie dysków
  qbittorrent                           # Klient do torrentów
  google-fonts                          # Paczka czcionek od Google Fonts
  unrar                                 # Wypakowywanie archiwów .rar
  p7zip                                 # Wypakowywanie archiwów .7z
  gearlever                             # Pomocnik plików appimage
  kitty                                 # Terminal ze wsparciem GPU
  btrfs-assistant                       # Asystent dysków btrfs
  alsa-utils                            # alsamixer czasem się przydaje
  waydroid-helper                      # Pomocnik zarządzania waydroidem
  distrobox                            # Kontenery dystrybucji
  kontainer                            # GUI do Distroboxa
  google-chrome
  spotify
  youtube-music
  upscayl
  htop
  ncdu
  nload
  yt-dlp
  ffmpeg
  headsetcontrol
  wget
  inxi
  pciutils
  lm_sensors
  localsend

  ## KDE Plazma
  kdePackages.kate                      # Edytor tekstu
  kdePackages.kdenlive                  # Do Edycji wideo
  avidemux                              # Przycinanie filmów
  haruna                                # Oglądanie filmów
  kdePackages.filelight


  ## Narzędzia do gier
  mangohud                              # FPSY, temperatury
  protonplus                            # Aktualizacje proton-ge
  winetricks                            # Do instalacji bibliotek w wine
  lutris                                # Najnowszy lutris
  heroic                                # Najnowszy Heroic Games Launcher
  goverlay                              # GOverlay

  ## Gry
  prismlauncher                         # Beat Saber Launcher
  
  ## Komunikacja
  (discord.override { withOpenASAR = true; withVencord = true; }) # Discord z vencord i openasar
  discord-rpc                           # Rich presence

  ## Programowanie
  stable.github-desktop                 # GitHub
  filezilla
];

environment.plasma6.excludePackages = with pkgs.kdePackages; [ #Usuwanie zbędnych aplikacji domyślnych z plazmy
  kdepim-runtime
  elisa
];

environment.variables = rec { # Naprawia integracje systemu z GTK (Np Zen browser)
    GSETTINGS_SCHEMA_DIR="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0/schemas";
  }; 

programs = {
    firefox.enable = true;             # Włącz Instalację Firefox
    steam = { 
      enable = true;                                  # Włącz steam
      protontricks.enable = true;                     # dodaj protontricks
      remotePlay.openFirewall = true;                 # Steam Remote Play
      dedicatedServer.openFirewall = true;            # Otwórz porty dla Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true;  # Otwórz porty dla Steam Local Network Game Transfers
      #extest.enable = true;                           # Tłumacz kliknięcia X11 na wayland dla steaminput
    };

    gamescope = {
      enable = true;                      # Dodaj/usuń Gamescope
      capSysNice = true;                 # Zezwól na wysoki priorytet
    };

    obs-studio = {
      enable = true;                      # Dodaj obs-studio do systemu
      enableVirtualCamera = false;         # Wsparcie wirtualnej kamery
      plugins = with pkgs.obs-studio-plugins; [ # Lista pluginów
        waveform
        input-overlay
        obs-aitum-multistream
        obs-vkcapture
        obs-tuna
        obs-text-pthread
        obs-retro-effects
        obs-stroke-glow-shadow
        obs-markdown
        ];
    };
};
}
