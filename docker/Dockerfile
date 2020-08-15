FROM alpine:3.12

ENV ZONE_ID=""
ENV RECORD_ID=""
ENV RECORD_NAME=""
ENV AUTH_TOKEN=""
ENV DEBUG="false"

RUN \
    apk add --no-cache \
        bash \
        curl

COPY update-dns.sh /

CMD [ "/update-dns.sh" ]
