{
  user,
  pkgs,
  ...
}: let
  source = pkgs.fetchgit {
    url = "https://codeberg.org/Vicenzo/wezterm";
    sha256 = "sha256-LWqLoEf7aBF1addnhBpecAn0mdvTLY415GIWIFBCYYM=";
  };
  source2 = pkgs.fetchgit {
    url = "https://codeberg.org/Vicenzo/xplr";
    sha256 = "sha256-/gf3bFgWMq8dxT2L5I2w27kqHOO9TT/SU2BNPyI+umY=";
  };
in {
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.11";
    file.wezterm = {
      inherit source;
      target = ".config/wezterm";
    };
    file.xplr = {
      source = source2;
      target = ".config/xplr";
    };
    packages = with pkgs; [xplr];
  };
}
