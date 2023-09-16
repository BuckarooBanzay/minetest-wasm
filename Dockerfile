FROM ubuntu:22.04 as builder
RUN apt-get update &&\
	DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y wget python3 git build-essential cmake tclsh zip zstd
COPY ./wasm-build /minetest-wasm
RUN cd /minetest-wasm &&\
	ls -la &&\
	./install_emsdk.sh &&\
	./build_all.sh

FROM alpine:3.18.3
COPY --from=builder /minetest-wasm/www/ /www