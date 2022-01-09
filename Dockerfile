FROM alpine

RUN apk add graphviz
RUN apk add rsync
RUN apk add openssh

CMD ["/bin/sh"]
