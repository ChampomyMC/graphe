FROM alpine

RUN apk add graphviz
RUN apk add rsync
RUN apk add openssh
RUN apk add make
RUN apk add git
RUN apk add terminus-font ttf-inconsolata ttf-dejavu font-bitstream-* font-noto font-noto-* ttf-font-awesome font-noto-extra




CMD ["/bin/sh"]
