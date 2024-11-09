OPENRESTY_VERSION ?= 1.27.1.1
LUAROCKS_VERSION ?= 3.7.0

build: build-heroku-18 build-heroku-20 build-heroku-24

build-heroku-18:
	@echo "Building OpenResty in Docker for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-18" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:18-build bin/build /buildpack/dist/openresty-heroku-18.tar.gz

build-heroku-20:
	@echo "Building OpenResty in Docker for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-20" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:20-build bin/build /buildpack/dist/openresty-heroku-20.tar.gz

build-heroku-24:
	@echo "Building OpenResty in Docker for heroku-24 ..."
	@docker run -u root -v $(shell pwd):/buildpack -w /buildpack --rm -it \
		 -e "STACK=heroku-24" -e "OPENRESTY_VERSION=$(OPENRESTY_VERSION)" -e "LUAROCKS_VERSION=$(LUAROCKS_VERSION)" \
		heroku/heroku:24-build bin/build /buildpack/dist/openresty-heroku-24.tar.gz

shell-heroku-18:
	@echo "Start a Docker shell for heroku-18 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-18" -w /buildpack heroku/heroku:18-build bash


shell-heroku-20:
	@echo "Start a Docker shell for heroku-20 ..."
	@docker run -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-20" -w /buildpack heroku/heroku:20-build bash

shell-heroku-24:
	@echo "Start a Docker shell for heroku-24 ..."
	@docker run -u root -v $(shell pwd):/buildpack --rm -it -e "STACK=heroku-24" -w /buildpack heroku/heroku:24-build bash

release:
	git commit -a -m "Rebuilding stacks"
	git push origin master
