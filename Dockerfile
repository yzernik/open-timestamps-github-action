FROM python:3.8-slim-buster

RUN DEBIAN_FRONTEND=noninteractive apt-get \
    update && \
    apt-get install -y \
    build-essential \
    git \
    gnupg

RUN pip install opentimestamps-client

COPY LICENSE README.md ots-git-gpg-wrapper.sh /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
