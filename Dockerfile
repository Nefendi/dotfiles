FROM ubuntu:groovy

ENV TZ=Europe/Warsaw

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /WORKSPACE

COPY * /WORKSPACE/

RUN apt update && apt -y install zsh curl tmux neovim npm git universal-ctags cmake xclip fasd

CMD ["/bin/bash", "prepare.sh"]
