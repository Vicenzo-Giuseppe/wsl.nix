{
  wsl,
  home,
  host,
  user,
  inputs,
  system,
}:
with builtins; let
  sharedModules = map (i: "${../home}/${i}") (attrNames (readDir ../home));
  colors = import ./colors.nix;
in [
  home.nixosModules.home-manager
  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${user} = {};
      sharedModules = sharedModules;
      extraSpecialArgs = {
        inherit host user inputs system colors;
      };
    };
  }
  wsl.nixosModules.wsl
]
