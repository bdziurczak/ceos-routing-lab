FROM debian:stable-slim

# Install networking and utility packages
RUN apt-get update && apt-get install -y \
    iproute2 \
    sudo \
    passwd \
    iputils-ping \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Make /usr/local/bin ready for scripts
RUN mkdir -p /usr/local/bin && chmod 755 /usr/local/bin

# Default user and working directory
USER root
WORKDIR /root

CMD ["/bin/bash"]