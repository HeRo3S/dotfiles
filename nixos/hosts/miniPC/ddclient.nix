{ config, ... }:
{
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";

    zone = "hero3s.dev";
    domains = [ "gaming.hero3s.dev" ];

    # Discover the router's public IPv4 rather than the machine's local IP.
    usev4 = "webv4, webv4=ipify-ipv4";
    usev6 = "";
    interval = "5min";

    passwordFile = config.age.secrets.dnsAPI.path;
  };
}
