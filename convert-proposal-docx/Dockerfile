
FROM pandoc/core:2.19

COPY converter /bin
RUN chmod +x /bin/converter

ENTRYPOINT ["converter"]
