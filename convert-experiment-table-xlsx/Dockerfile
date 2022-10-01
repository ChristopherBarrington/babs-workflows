
FROM python:slim

RUN pip install --no-cache-dir xlsx2csv

COPY converter /bin
RUN chmod +x /bin/converter

ENTRYPOINT ["converter"]
