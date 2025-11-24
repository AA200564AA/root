FROM kalilinux/kali-rolling
# Update system
RUN apt update && apt full-upgrade -y
# Install core tools (NetHunter style)
RUN apt install -y \
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
    openssh-server
# Setup root
RUN echo "root:rootpass123" | chpasswd
# Prepare SSH folder
RUN mkdir -p /var/run/sshd
# Expose SSH port
EXPOSE 22
# Start SSH + Bash
CMD service ssh start && bash
