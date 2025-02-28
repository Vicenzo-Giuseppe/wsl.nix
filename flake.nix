{
  outputs = inputs @ {
    self,
    home,
    nixpkgs,
    utils,
    neovim,
    wsl,
    ...
  }: let
    user = "vicenzo";
    host = "wsl";
    system = "x86_64-linux";
    colors = import ./colors;

    modules = [
      home.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = {};
          sharedModules =
            map (i: "${./home}/${i}")
            (builtins.attrNames (builtins.readDir ./home));
          extraSpecialArgs = {inherit host user inputs system colors;};
        };
      }
      wsl.nixosModules.wsl
    ];
    sharedOverlays = [
      utils.overlay
      neovim.overlays.default
    ];
    channelsConfig = import ./nix {inherit nixpkgs user;};
    hosts = {
      wsl = {
        modules = [
          ./system
        ];
        extraArgs = {inherit system user host;};
      };
    };
    hostDefaults = {
      inherit modules;
      channelName = "unstable";
      extraArgs = {inherit user;};
    };
    outputsBuilder = x: let
      pkgs = x.nixpkgs;
    in {
      formatter = pkgs.alejandra;
    };
  in
    utils.lib.mkFlake {
      inherit self inputs sharedOverlays channelsConfig outputsBuilder hostDefaults hosts;
      supportedSystems = [system];
    };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    wsl.url = "github:nix-community/NixOS-WSL";
  };
  nixConfig = {
    extra-substituters = [
      "https://zv.cachix.org"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    extra-trusted-public-keys = [
      "zv.cachix.org-1:IvFyOKHzPNNVSapGzeNPbrF65OoX/r+MROLHpGwsYfg="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };
}
