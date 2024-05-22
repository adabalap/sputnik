FROM alpine:latest

# Install necessary packages
RUN apk update && \
    apk add --no-cache bash openssh curl shadow ttyd && \
    rm -rf /var/cache/apk/*

# Set up SSH server
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    /usr/bin/ssh-keygen -A

# Create a script to create user's home directory and set permissions
RUN mkdir -p /usr/local/bin && \
    printf "#!/bin/bash\nif [ ! -d \"\$HOME\" ]; then mkdir \"\$HOME\"; fi\nchown -R \$USERNAME:\$(id -g \$USERNAME) \"\$HOME\"\nexec chroot /home/$USERNAME\n" > /usr/local/bin/setup.sh && \
    chmod +x /usr/local/bin/setup.sh

# Expose ports
EXPOSE 22 7681

# Create a new user and start SSH server and ttyd
CMD ["/bin/sh", "-c", "adduser -D $USERNAME && echo \"$USERNAME:$PASSWORD\" | chpasswd && /usr/sbin/sshd && ttyd -p 7681 login && /usr/local/bin/setup.sh"]
