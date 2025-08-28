{user, ...}: {
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = user;
    startMenuLaunchers = true;
    useWindowsDriver = true;
    usbip = {
      enable = true;
    };
  };
}
