FROM alpine:3.4

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> \
 /etc/apk/repositories \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> \
 /etc/apk/repositories \
 && apk -U --no-progress upgrade \
 && apk -U --no-progress add tor

EXPOSE 9001 9050

VOLUME [ "/etc/tor" "/var/lib/tor" ]

USER tor

ENTRYPOINT [ "/usr/bin/tor" ]
