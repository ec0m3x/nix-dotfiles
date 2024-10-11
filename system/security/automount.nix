{ ... }:

{
  #services.devmon.enable = true;
  services.gvfs.enable = true;

  fileSystems."/home/ecomex/NVME-SSD" = {
    device = "/dev/disk/by-uuid/36040a9c-9eec-4c8b-bd76-9f6ec5340d88";
    fsType = "auto";
    options = [ "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show"]; # Optional, similar to mount options in fstab
  };
}
