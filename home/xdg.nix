{...}: let
in {
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {_ = "\$HOME/Code";};
    };
  };
}
