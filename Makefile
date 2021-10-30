build:
	sudo docker build --no-cache -t nvim .
run:
	sudo docker run -it --name nvim-ide nvim
