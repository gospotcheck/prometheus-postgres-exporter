FROM alpine:3.12.0

RUN apk add --update wget ca-certificates

RUN wget https://github.com/prometheus-community/postgres_exporter/releases/download/v0.11.1/postgres_exporter-0.11.1.linux-amd64.tar.gz && \
  tar -zxvf /postgres_exporter-0.11.1.linux-amd64.tar.gz && \
  mv /postgres_exporter-0.11.1.linux-amd64/postgres_exporter /postgres_exporter && \
  chmod +x /postgres_exporter && \
  rm -Rf /postgres_exporter-0.11.1.linux-amd64*

COPY queries.yaml /etc/queries.yaml

RUN chmod 0444 /etc/queries.yaml

CMD /postgres_exporter --extend.query-path /etc/queries.yaml --log.level debug

