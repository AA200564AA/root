FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0

# Update & install desktop + VNC + browser-based VNC (noVNC)
RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    x11vnc xvfb \
    wget curl sudo git \
    && apt clean

# Set password for VNC
RUN mkdir /root/.vnc && x11vnc -storepasswd "xx200564" /root/.vnc/passwd

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

EXPOSE 20002

# Start desktop + VNC + web interface
CMD Xvfb :0 -screen 0 1280x720x16 & \
    startxfce4 & \
    x11vnc -forever -usepw -display :0 -rfbport 5900 & \
    /opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 20002
