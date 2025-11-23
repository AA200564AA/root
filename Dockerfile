FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install XFCE desktop + XRDP
RUN apt update && apt install -y \
    xrdp \
    xfce4 \
    xfce4-goodies \
    sudo \
    dbus-x11 \
    && apt clean

# Set root password
RUN echo "root:xx200564" | chpasswd

# Make XRDP use XFCE
RUN echo xfce4-session > /root/.xsession

# Change XRDP port to 20002
RUN sed -i 's/3389/20002/g' /etc/xrdp/xrdp.ini

# Allow root login
RUN sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config || true

EXPOSE 20002

CMD service xrdp start && tail -f /dev/null
