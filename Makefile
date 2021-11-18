build:
	sudo docker build --no-cache -t nvim .

run:
	sudo docker run\
    -it\
    --rm\
    -v $(FOLDER):/home/neovim/Workspace\
    -v nvim_config_volume:/home/neovim/.config\
    nvim:latest\
    $(OPTIONS)

edit_nvim_config:
	sudo docker run\
    -it\
    --rm\
    -v nvim_config_volume:/home/neovim/Workspace\
    -v nvim_config_volume:/home/neovim/.config\
    nvim:latest\
    .
