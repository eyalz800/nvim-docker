## Getting Started

This section outlines the steps to set up and run the nvim-docker environment.

### Prerequisites
Ensure you have Docker/Podman/WSL installed on your system.

### Setup Instructions

1.  **Download the Environment Archive:**
    First, download the `env-amd64.tar.xz` (assuming amd64) archive from the releases page (e.g., GitHub releases). This file contains the pre-built Docker image.

2.  **Import the Docker Image:**
    Import the decompressed tar file into Docker to create the `env:latest` image:
    ```sh
    xz -cd env-amd64.tar.xz | docker import - env:latest
    ```

3.  **Run the Docker Container:**
    Once the image is imported, you can run a container from it. This command will launch an interactive `zsh` session within the container, with the user set to `user` and the working directory set to `/home/user`. The container will be automatically removed upon exit (`--rm`).
    ```sh
    docker run -e TERM -w /home/user --rm --user user --detach-keys="ctrl-q,ctrl-q" -it env:latest zsh
    ```
    **Explanation of flags:**
    -   `-e TERM`: Propagates your terminal's `TERM` environment variable into the container, improving compatibility with terminal applications.
    -   `-w /home/user`: Sets the working directory inside the container to `/home/user`.
    -   `--rm`: Automatically removes the container filesystem when the container exits.
    -   `--user user`: Runs the command inside the container as the `user` user.
    -   `-it`: Allocates a pseudo-TTY (`-t`) and keeps stdin open (`-i`) even if not attached, allowing for interactive use.

4. Similarly, `podman import` commands are available for Podman, mirroring the functionality of Docker. On Windows, `wsl --import` provides a comparable feature, although with distinct syntax.

5. If you want to start neovim directly when starting the docker, the following script does that while trying to keep pathsin sync between host and docker:
```sh
local expanded_path=
if [[ -n $1 ]]; then
    eval expanded_path="${1}"
    if [[ $expanded_path == /* ]]; then
        expanded_path="/home/user/root$expanded_path"
    fi
fi
podman run --rm -e TERM -it --user user --detach-keys="ctrl-q,ctrl-q" --privileged -v /:/home/user/root -w /home/user/root`pwd` env:latest zsh -c "nvim $expanded_path ${@:2}"
```

