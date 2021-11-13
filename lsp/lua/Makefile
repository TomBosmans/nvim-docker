install:
	pacman --noconfirm -S ninja
	git clone https://github.com/sumneko/lua-language-server /usr/local/bin/lua-language-server
	cd /usr/local/bin/lua-language-server &&\
  	git submodule update --init --recursive &&\
  	cd 3rd/luamake &&\
  	./compile/install.sh &&\
  	cd ../.. &&\
		./3rd/luamake/luamake rebuild &&\
		./bin/Linux/lua-language-server
