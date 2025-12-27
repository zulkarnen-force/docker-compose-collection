FROM python:3.11-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates unzip && \
    rm -rf /var/lib/apt/lists/*

# Install rclone
RUN curl -fsSL https://rclone.org/install.sh | bash

# Ensure rclone config directory exists
RUN mkdir -p /root/.config/rclone

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Default command (can be overridden)
# ENTRYPOINT ["/bin/bash", "-c"]
