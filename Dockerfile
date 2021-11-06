FROM archlinux:latest

ENV SHELL=/bin/zsh

ARG USER_NAME=neovim

RUN pacman --noconfirm -Syu\
      sudo\
      neovim\
      zsh\
      bat\
      exa\
      git\
      fzf\
      make

RUN useradd\
  --create-home\
  --user-group\
  --shell $SHELL\
  $USER_NAME

USER $USER_NAME
WORKDIR /home/$USER_NAME/Workspace

RUN mkdir ~/.config

RUN git clone https://github.com/TomBosmans/nvim.git ~/.config/nvim &&\
    git clone https://github.com/TomBosmans/zsh.git ~/.config/zsh
RUN cd ~/.config/zsh &&\
    git submodule init &&\
    git submodule update &&\
    cd -
RUN make --directory ~/.config/zsh link

RUN rm -rf ~/.bash_logout &&\
    rm -rf ~/.bashrc &&\
    rm -rf ~/.bash_profile

RUN nvim --headless\
  -c "autocmd User PackerComplete quitall"\
  -c "lua require('packer').sync()"

ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
