{
  outputs = inputs @ {
    self,
    home,
    nixpkgs,
    utils,
    neovim,
    wsl,
    ...
  }:
    with builtins; let
      config = fromTOML (readFile ./config.toml);
      inherit (config.options) system host user;
      hosts = {
        ${host} = {
          modules = [
            ./system
          ];
          extraArgs = {inherit system user host;};
        };
      };
      hostDefaults = {
        modules = import ./system/home-manager.nix {inherit wsl home host user inputs system;};
        channelName = "unstable";
        extraArgs = {inherit user;};
      };
      channelsConfig = import ./nix {inherit nixpkgs user;};
      sharedOverlays = [
        utils.overlay
        neovim.overlays.default
      ];
      outputsBuilder = x: {
        formatter = x.nixpkgs.alejandra;
      };
    in
      utils.lib.mkFlake {
        inherit self inputs sharedOverlays channelsConfig outputsBuilder hostDefaults hosts;
        supportedSystems = [system];
      };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home.url = "github:nix-community/home-manager";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    wsl.url = "github:nix-community/NixOS-WSL";
  };
}
