# Docker Image with SSH and ttyd

This Docker image is based on the latest Alpine Linux image. It includes an SSH server and ttyd, a terminal emulator for the web.

## Features

- **SSH Server**: The image includes an SSH server that is configured to not allow root login. Password authentication is enabled.
- **ttyd**: ttyd is a terminal emulator for the web. It is included in this image and is configured to be writable.
- **User Setup**: A script is included that creates a home directory for a user and sets the appropriate permissions. The user is created when the container starts.

## Ports

The following ports are exposed:

- `22`: SSH server
- `7681`: ttyd

## Usage

To use this image, you can pull it from Docker Hub (replace `adabalap/vulcan` with your Docker image name):

```bash
docker pull adabalap/vulcan:latest
