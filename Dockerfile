FROM alpine

RUN apk add graphviz
RUN apk add rsync
RUN apk add openssh
RUN apk add make
RUN apk add git

CMD ["/bin/sh"]
