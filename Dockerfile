# Use an official Ubuntu runtime as a parent image
FROM ubuntu:latest

# Install OpenSSH and Shell In A Box
RUN apt-get update && apt-get install -y openssh-server shellinabox

# Create the guest user
RUN useradd -m guest && \
    echo "guest:guest" | chpasswd && \
    mkdir /home/guest/.ssh && \
    chmod 700 /home/guest/.ssh

# Configure SSH for the guest user
RUN echo 'PermitRootLogin no\nPasswordAuthentication yes\nAllowUsers guest' > /etc/ssh/sshd_config

# Configure Shell In A Box
RUN echo "SHELLINABOX_PORT=4200\nSHELLINABOX_ARGS='--no-beep --disable-ssl'" > /etc/default/shellinabox

# Expose the SSH and Shell In A Box ports
EXPOSE 22 4200

# Start the SSH server and Shell In A Box
CMD service shellinabox start && /usr/sbin/sshd -D
