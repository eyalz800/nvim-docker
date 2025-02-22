FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y sudo git wget

RUN useradd -m -s /bin/bash user && \
    echo "user:password" | chpasswd

RUN usermod -aG sudo user

RUN echo "user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

USER user

ENV USER=username

RUN sudo apt-get install -y kitty

WORKDIR /home/user
RUN mkdir -p git

WORKDIR /home/user/git
RUN git clone https://github.com/eyalz800/install

WORKDIR /home/user/git/install
RUN git clone https://github.com/eyalz800/macos-terminal-settings
RUN git clone https://github.com/eyalz800/windows-terminal-settings
RUN wget https://github.com/kovidgoyal/kitty/releases/download/v0.39.1/kitty-0.39.1-x86_64.txz
RUN wget https://github.com/kovidgoyal/kitty/releases/download/v0.39.1/kitty-0.39.1-arm64.txz

WORKDIR /home/user
ENV TERM=xterm-kitty

CMD ["zsh"]
