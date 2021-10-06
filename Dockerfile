FROM alpine:3.10

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    python3

RUN pip3 install opentimestamps-client

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
