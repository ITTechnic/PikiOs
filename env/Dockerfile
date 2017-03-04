FROM ubuntu:latest

USER 0

RUN apt-get update && \
    apt-get -y install qemu-user-static realpath zip sudo lsof git

CMD /build/scripts/build.sh
