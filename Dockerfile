FROM ubuntu:18.04

RUN apt-get update && apt-get install -y  \
        libncurses5-dev \
#        libgnome2-dev \
#        libgnomeui-dev \
#        libgtk2.0-dev \
        libgtk-3-dev \
        libatk1.0-dev \
        libbonoboui2-dev \
        libcairo2-dev \
        libx11-dev \
        libxpm-dev \ 
        libxt-dev \ 
#        python-dev \
        python3-dev \
        ruby-dev \
        lua5.1 \
        liblua5.1-dev \
        libperl-dev \
        git

