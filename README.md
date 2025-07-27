## Getting Started

This section outlines the steps to set up and run the nvim-docker environment.

### Prerequisites
Ensure you have Docker/Podman/WSL installed on your system.

### Setup Instructions

1.  **Download the Environment Archive:**
    First, download the `env-amd64.tar.xz` (assuming amd64) archive from the releases page (e.g., GitHub releases). This file contains the pre-built Docker image.

2.  **Decompress the Archive:**
    Decompress the downloaded archive using `xz`:
    ```sh
    xz -d env-amd64.tar.xz
    ```
    This will create an `env-amd64.tar` file in the same directory.

3.  **Import the Docker Image:**
    Import the decompressed tar file into Docker to create the `env-amd64` image:
    ```sh
    docker import env-amd64.tar env-amd64
    ```

4.  **Run the Docker Container:**
    Once the image is imported, you can run a container from it. This command will launch an interactive `zsh` session within the container, with the user set to `user` and the working directory set to `/home/user`. The container will be automatically removed upon exit (`--rm`).
    ```sh
    docker run -e TERM -w /home/user --rm --user user -it env-amd64 zsh
    ```
    **Explanation of flags:**
    -   `-e TERM`: Propagates your terminal's `TERM` environment variable into the container, improving compatibility with terminal applications.
    -   `-w /home/user`: Sets the working directory inside the container to `/home/user`.
    -   `--rm`: Automatically removes the container filesystem when the container exits.
    -   `--user user`: Runs the command inside the container as the `user` user.
    -   `-it`: Allocates a pseudo-TTY (`-t`) and keeps stdin open (`-i`) even if not attached, allowing for interactive use.

5. Similarly, `podman import` commands are available for Podman, mirroring the functionality of Docker. On Windows, `wsl --import` provides a comparable feature, although with distinct syntax.

