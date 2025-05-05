docker rm openvpn3-client -f
docker build -t openvpn3-client .

docker run -it --rm \
  --cap-add=NET_ADMIN \
  --privileged \
  --device /dev/net/tun \
  -p 1194:1194/udp \
  --name openvpn3-client \
  openvpn3-client
