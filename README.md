```zsh
nvim() {
  sudo docker run\
    -it\
    --rm\
    --name nvim\
    -v $PWD:/home/neovim/Workspace\
    nvim:latest\
    $@
}
```
