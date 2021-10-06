FROM python:3.8-slim-buster

RUN pip install opentimestamps-client

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
