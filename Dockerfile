FROM ubuntu:22.04 as builder
RUN apt-get update &&\
	DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y wget python3 git build-essential cmake tclsh zip zstd
RUN git clone https://github.com/paradust7/minetest-wasm /minetest-wasm
RUN cd /minetest-wasm && git checkout 891fe65251a7fd1f55dd3b435a6551bcb0683a2a
RUN cd /minetest-wasm &&\
	./install_emsdk.sh &&\
	./build_all.sh

FROM alpine:3.18.3
COPY --from=builder /minetest-wasm/www/ /www