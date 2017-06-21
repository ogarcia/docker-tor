FROM alpine:latest

RUN apk -U --no-progress upgrade \
 && apk -U --no-progress add tor

EXPOSE 9001 9050

VOLUME [ "/etc/tor", "/var/lib/tor" ]

USER tor

ENTRYPOINT [ "/usr/bin/tor" ]
