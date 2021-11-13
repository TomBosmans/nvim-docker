build:
	sudo docker build --no-cache -t nvim .
run:
	sudo docker run -it --rm nvim
config:
	sudo docker run -it --rm --workdir /home/neovim/.config/nvim nvim
