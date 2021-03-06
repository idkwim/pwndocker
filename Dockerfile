FROM phusion/baseimage:latest
MAINTAINER skysider <skysider@163.com>

RUN dpkg --add-architecture i386 && \
	apt-get -y update && \
	apt install -y \
	libc6:i386 \
	libc6-dbg:i386 \
	libc6-dbg \
	lib32stdc++6 \
	g++-multilib \
	net-tools \
	libffi-dev \
	libssl-dev \
	python \
	python-pip \
	python-capstone \
	ruby2.3 \
	tmux \
	strace \
	ltrace \
	nasm \
	git \
	wget \
	gdb --fix-missing && \
	rm -rf /var/lib/apt/list/*

RUN pip install \
	ropgadget \
	pwntools \
	zio && \
	rm -rf ~/.cache/pip/*

RUN gem install \
	one_gadget && \
	rm -rf /var/lib/gems/2.3.*/cache/*
	
RUN git clone https://github.com/longld/peda.git ~/peda && \
	git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb && \
	cp ~/Pwngdb/.gdbinit ~/

RUN mkdir -p /ctf/work && \
	wget https://raw.githubusercontent.com/inaz2/roputils/master/roputils.py -O /ctf/roputils.py

COPY linux_server linux_serverx64 /ctf/

RUN chmod a+x /ctf/linux_server /ctf/linux_serverx64

WORKDIR /ctf/work/

ENTRYPOINT ["/bin/bash"]