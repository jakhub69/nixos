{ config, lib, pkgs, ... }:

{
# Bootloader
boot = {
  loader.efi.canTouchEfiVariables = true;      # Pozwól na modyfikację zmiennych EFI
  loader.systemd-boot.enable = true;           # Użyj standardowego systemd-boot zamiast Limine
  loader.systemd-boot.configurationLimit = 10; # Opcjonalnie: trzymaj max 10 generacji w menu startowym

  tmp.cleanOnBoot = true;                      # Czyszczenie TMP przy ładowaniu systemu
  kernelPackages = pkgs.linuxPackages_zen;     # Jądro systemu
  kernelModules = ["vhba" "ntsync"];
  kernelParams = [ "nohibernate" "usbcore.autosuspend=-1" "mitigations=off" "loglevel=2" "nvidia-drm.modeset=1" ];
  kernel.sysctl = {
    "kernel.split_lock_mitigate" = 0;
    "vm.max_map_count" = 2147483642;
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "kernel.sched_cfs_bandwidth_slice_us" = 3000;
    "net.ipv4.tcp_fin_timeout" = 5;
    "vm.dirty_ratio" = 3;
    "vm.dirty_bytes" = 50331648;
    "vm.dirty_background_bytes" = 16777216;
    "vm.dirty_background_ratio" = 2;
    "vm.dirty_expire_centisecs" = 3000;
    "vm.dirty_writeback_centisecs" = 1500;
    "vm.min_free_kbytes" = 59030;
  };

  supportedFilesystems = ["exfat" "btrfs" "ntfs"];
};

# Szybsze zamykanie systemu
systemd.settings.Manager = {
  DefaultTimeoutStopSec = "12s";
};

# Profil zasilania CPU
powerManagement = {
     enable = true;
     powertop.enable = true;
     cpuFreqGovernor = "performance"; 
};

}
