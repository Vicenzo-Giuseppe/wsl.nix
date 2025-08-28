{
  pkgs,
  user,
  ...
}: {
  # Immich
  services.immich = {
    enable = true;
    port = 2283;
    user = user;
    host = "0.0.0.0"; # acessível do Windows e rede local
    environment = {
      IMMICH_LOG_LEVEL = "verbose";
    };
    redis.enable = true;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server"; # Permite roteamento de sub-rede se precisar
    extraSetFlags = [
      "--advertise-exit-node"
      "--accept-dns"
    ];
  };
  networking.firewall = {
    allowedUDPPorts = [3478]; # Se precisar para WebRTC/Upload
  };
  systemd.services.tailscaled.wantedBy = ["multi-user.target"];
}
