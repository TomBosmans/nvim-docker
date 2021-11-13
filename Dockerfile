# Lets take a linux that has up to date packages.
FROM archlinux:latest

ENV SHELL=/bin/zsh

# The name for our user.
ARG USER_NAME=neovim
# set the bin folder location
ARG BIN_FOLDER=/usr/local/bin

# Install our arch packages.
RUN pacman --noconfirm -Syu\
      sudo\
      neovim\
      zsh\
      bat\
      exa\
      git\
      fzf\
      make\
      gcc

# Install lsp
ADD lsp/ $BIN_FOLDER
RUN make --directory $BIN_FOLDER/typescript install

# Create our user with its home dir, group and shell.
RUN useradd\
  --create-home\
  --user-group\
  --shell $SHELL\
  $USER_NAME

# Set the user and the workdir
USER $USER_NAME
WORKDIR /home/$USER_NAME/Workspace

# Create the .config folder.
RUN mkdir ~/.config

# Clone the git repos
RUN git clone https://github.com/TomBosmans/nvim.git ~/.config/nvim &&\
    git clone https://github.com/TomBosmans/zsh.git ~/.config/zsh

# Clone zsh submodules, these are the plugins.
RUN cd ~/.config/zsh &&\
    git submodule init &&\
    git submodule update &&\
    cd -

# Link zsh, nvim is already in the correct spot.
RUN make --directory ~/.config/zsh link

# Remove the bash config files, we don't need them because we will be using zsh.
RUN rm -rf ~/.bash_logout &&\
    rm -rf ~/.bashrc &&\
    rm -rf ~/.bash_profile

# Install all the nvim Packages.
RUN nvim --headless\
  -c "autocmd User PackerComplete quitall"\
  -c "lua require('packer').sync()"

# Set the shell script as our Entrypoint, makes nvim work as we want.
ADD entrypoint.sh $BIN_FOLDER
ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]
