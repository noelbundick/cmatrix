# FROM debian:stretch
FROM arm32v7/debian:stretch

RUN apt-get update \
  && apt-get install -y build-essential dh-autoreconf libncurses5-dev

WORKDIR /cmatrix
COPY . .

RUN autoreconf -i \
  && ./configure \
  && make \
  && make install

CMD ["/usr/local/bin/cmatrix", "-ba"]
