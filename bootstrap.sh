if [[ ! -z $DEBUG && $DEBUG != "0" ]]; then
    echo "Running DEBUG mode"
fi

if [[ -f ./.env ]]; then
    source ./.env
fi

if [[ -z $SERVER_NAME ]]; then
    echo "Run export SERVER_NAME=udp://VPN.SERVERNAME.COM to define udp first"
    exit 1
fi

if [[ -z $CLIENTNAME ]]; then
    echo "Run export CLIENTNAME=xxxxx to define client name first"
    exit 1
fi

docker-compose run --rm ovpn ovpn_genconfig -u $SERVER_NAME
docker-compose run --rm ovpn ovpn_initpki
docker-compose up -d
docker-compose run --rm ovpn easyrsa build-client-full "$CLIENTNAME" nopass
docker-compose run --rm ovpn ovpn_getclient "$CLIENTNAME" > "$CLIENTNAME.ovpn"
