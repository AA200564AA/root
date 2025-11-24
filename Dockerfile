FROM kalilinux/kali-rolling

# Update, upgrade, and install all in one layer for efficiency
RUN apt update -qq && apt full-upgrade -y -qq && \
    apt install -y -qq --no-install-recommends \
    nmap \
    hydra \
    sqlmap \
    metasploit-framework \
    beef-xss \
    aircrack-ng \
    wordlists \
    wireshark \
    python3 python3-pip \
    git curl wget nano zip unzip \
    kali-tools-top10 \
    kali-tools-wireless \
    kali-tools-web \
    kali-tools-passwords \
    openssh-server && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Configure SSH to use port 20002
RUN sed -i 's/#\?Port 22/Port 20002/' /etc/ssh/sshd_config

# Setup root
RUN echo "root:rootpass123" | chpasswd

# Prepare SSH folder
RUN mkdir -p /var/run/sshd

# Expose SSH port
EXPOSE 20002

# Start SSH + Bash
CMD service ssh start && bash
