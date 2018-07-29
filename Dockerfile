# FROM debian:stretch
#FROM debian@sha256:6e60788846c5b2196fbad508c94bbccb0b5b0e7c1257804e89967ba7ff480475
FROM arm32v7/debian AS build

RUN apt-get update \
  && apt-get install -y build-essential dh-autoreconf libncurses5-dev

WORKDIR /cmatrix
COPY . .

RUN autoreconf -i \
  && ./configure \
  && make \
  && make install

FROM arm32v7/debian

RUN apt-get update \
  && apt-get install -y libncurses5 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/cmatrix /usr/local/bin/cmatrix

CMD ["/usr/local/bin/cmatrix", "-ba"]
