
PREFIX := /usr/local
# Find available archives at https://github.com/vim/vim/releases. 
# Choose your version and enter below.
VERSION := 8.2.0210
VERSION_GENERAL := vim82

FEATURES := \
	--with-features=huge \
	--enable-multibyte \
	--enable-cscope \
	--enable-luainterp \
	--enable-rubyinterp \
	--enable-perlinterp \
	--enable-python3interp=yes \
	--with-python3-config-dir=$(python3-config --configdir) \
	--enable-gui=gtk3

all: image vim
.PHONY: all

image:
	@docker build \
		--tag=$(USER)/vim-build-dependencies \
		.
.PHONY: image

vim/$(VERSION):
	@mkdir -p vim
	@curl --location --progress-bar \
		https://github.com/vim/vim/archive/v$(VERSION).tar.gz \
		| tar --extract --gzip --directory=vim --transform 's/vim-//'


vim/$(VERSION)/src/vim: vim/$(VERSION)
	cd vim/$(VERSION) && \
		docker run \
			--rm \
			--user=$(shell id --user):$(shell id --group) \
			--volume=/etc/passwd:/etc/passwd:ro \
			--volume=/etc/group:/etc/group:ro \
			--volume=$(shell pwd)/vim/$(VERSION):$(shell pwd)/vim/$(VERSION) \
			--volume=$(PREFIX):$(PREFIX) \
			--workdir=$(shell pwd)/vim/$(VERSION) \
			$(USER)/vim-build-dependencies \
				sh -c './configure --prefix=$(PREFIX) $(FEATURES) && make VIMRUNTIMEDIR=$(PREFIX)/share/vim/$(VERSION_GENERAL)'

vim: vim/$(VERSION)/src/vim
.PHONY: vim

install: vim/$(VERSION)/src/vim
	make -C vim/$(VERSION) install
.PHONY: install

clean:
	make -C vim/$(VERSION) clean
.PHONY: clean

uninstall:
	make -C vim/$(VERSION) uninstall
.PHONY: uninstall
