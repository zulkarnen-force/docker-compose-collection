FROM ubuntu:24.04

# Set environment variables
ENV DISTRIBUTION=noble

# Install dependencies
RUN apt-get update && apt-get install -y \
     curl \
     gnupg \
     lsb-release \
     iproute2 \
     iptables \
     iputils-ping \
     systemd \
     ca-certificates \
     apt-transport-https \
     && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings    ### This might not exist in all distributions
RUN curl -sSfL https://packages.openvpn.net/packages-repo.gpg >/etc/apt/keyrings/openvpn.asc

# Add OpenVPN 3 Linux repository and key
# RUN curl -fsSL https://packages.openvpn.net/packages-repo.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/openvpn.gpg \
# && echo "deb [arch=amd64] https://packages.openvpn.net/openvpn3/debian $DISTRIBUTION main" > /etc/apt/sources.list.d/openvpn-packages.list
RUN echo "deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian $DISTRIBUTION main" >>/etc/apt/sources.list.d/openvpn3.list

# Install OpenVPN 3 Linux
RUN apt-get update && apt-get install -y openvpn3

# Create working directory
WORKDIR /home/ubuntu

# Copy your .ovpn config (optional)
COPY ./OpenVPN_Server_labmu.ovpn client.ovpn
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose OpenVPN port (optional)
EXPOSE 1194/udp
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]
# CMD ["openvpn3", "session-start", "--config", "client.ovpn"]
# Start OpenVPN 3 Interactive Service
# CMD ["openvpn3-service"]
# CMD ["openvpn3", "start"]
# CMD ["openvpn3", "session-start", "--config", "client.ovpn"]
# CMD ["tail", "-f", "/dev/null"]