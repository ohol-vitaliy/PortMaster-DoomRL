FROM monkeyx/retro_builder:arm64

RUN apt update \
	&& apt upgrade -y \
    && apt install -y lua5.1 liblua5.1-0-dev vim zip unzip

WORKDIR /root
RUN wget "http://downloads.freepascal.org/fpc/dist/3.2.2/aarch64-linux/fpc-3.2.2.aarch64-linux.tar" \
	&& tar -xvf fpc-3.2.2.aarch64-linux.tar \
	&& cd /root/fpc-3.2.2.aarch64-linux \
	&& printf "\nn\nn\n" | bash install.sh \
	&& rm /root/fpc-3.2.2.aarch64-linux.tar
# WORKDIR /root/fpc-3.2.2.aarch64-linux
# RUN printf "\nn\nn\n" | bash install.sh

WORKDIR /root
RUN git clone https://github.com/ohol-vitaliy/doomrl \
	&& git clone https://github.com/ohol-vitaliy/fpcvalkyrie

WORKDIR /root/doomrl
RUN ldconfig && mkdir tmp && lua5.1 makefile.lua

WORKDIR /root
RUN wget https://drl.chaosforge.org/file_download/41/drl-win-0998.zip \
	&& unzip drl-win-0998.zip \
	&& cp -r /root/drl-win-0998/mp3/* /root/doomrl/bin/mp3/ \
	&& cp -r /root/drl-win-0998/wavhq/* /root/doomrl/bin/wavhq/ \
	&& rm -rf /root/drl-win-0998*

WORKDIR /root/doomrl/bin
RUN zip -9 -r /root/drl.zip \
	backup modules mortem mp3 screenshot wavhq \
	colors.lua config.lua musichq.lua soundhq.lua \
	manual.txt version.txt version_api.txt \
	drl.wad core.wad drl

WORKDIR /root

