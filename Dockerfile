FROM archlinux:latest

ENV SHELL=/bin/zsh

ARG USER_NAME=neovim

RUN pacman -Syu --noconfirm &&\
    pacman --noconfirm -S\
      sudo\
      neovim\
      zsh\
      bat\
      exa\
      git\
      fzf\
      xclip

RUN useradd\
  --create-home\
  --user-group\
  --shell $SHELL\
  $USER_NAME

USER $USER_NAME
WORKDIR /home/$USER_NAME/Workspace

RUN mkdir ~/.config

RUN git clone https://github.com/TomBosmans/nvim.git ~/tmp_nvim &&\
    git clone https://github.com/TomBosmans/zsh.git ~/tmp_zsh &&\
    cp -r ~/tmp_zsh/zsh ~/.zsh &&\
    cp -r ~/tmp_zsh/zshrc ~/.zshrc &&\
    cp -r ~/tmp_nvim ~/.config/nvim/ &&\
    rm -rf ~/tmp_nvim &&\
    rm -rf ~/tmp_zsh

RUN rm -rf ~/.bash_logout &&\
    rm -rf ~/.bashrc &&\
    rm -rf ~/.bash_profile

RUN nvim --headless\
  -c "autocmd User PackerComplete quitall"\
  -c "lua require('packer').sync()"

ADD entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
