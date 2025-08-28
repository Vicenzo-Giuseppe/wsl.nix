{
  pkgs,
  host,
  ...
}: let
  imports = [
    ./cachix.nix
    ./user-config.nix
    ./wsl.nix
    ./immich.nix
    #./dualshock.nix
    #./anythingllm.nix
  ];
in {
  inherit imports;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };
  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [2283]; #Immich
  };
}
