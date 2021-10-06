FROM python:3.8-slim-buster

RUN apt-get install python3-dev

RUN pip install opentimestamps-client

COPY LICENSE README.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
