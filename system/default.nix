{
  pkgs,
  host,
  ...
}: let
  imports = [
    ./cachix.nix
    ./user-config.nix
    ./wsl.nix
  ];
in {
  inherit imports;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };
  networking = {
    hostName = host;
    networkmanager.enable = true;
  };
}
