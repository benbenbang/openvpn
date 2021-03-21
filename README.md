# OpenVPN Server

### References

Setup OpenVPN Server docker on Apple ARM

- Preview notes of docker on M1 chips: https://docs.docker.com/docker-for-mac/apple-m1/
  - Download link: https://desktop.docker.com/mac/stable/arm64/62029/Docker.dmg
- OpenVPN ARM arch image: https://hub.docker.com/r/giggio/openvpn-arm/

### Quick Start

```bash
docker-compose run --rm ovpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
docker-compose run --rm ovpn ovpn_initpki
docker-compose up -d
export CLIENTNAME="PASSWORD"
docker-compose run --rm ovpn easyrsa build-client-full "$CLIENTNAME" nopass
docker-compose run --rm ovpn ovpn_getclient "$CLIENTNAME" > "$CLIENTNAME.ovpn"
```

