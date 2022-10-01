
FROM python:slim

RUN pip install --no-cache-dir xlsx2csv

COPY run-xlsx2csv /bin
RUN chmod +x /bin/run-xlsx2csv

ENTRYPOINT ["run-xlsx2csv"]
