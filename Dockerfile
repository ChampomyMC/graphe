FROM alpine

RUN apk add graphviz
RUN apk add rsync
RUN apk add openssh
RUN apk add make

CMD ["/bin/sh"]
