FROM alpine:3.12.0

RUN apk add --update wget ca-certificates

RUN wget https://github.com/prometheus-community/postgres_exporter/releases/download/v0.9.0/postgres_exporter-0.9.0.linux-amd64.tar.gz && \
  tar -zxvf /postgres_exporter-0.9.0.linux-amd64.tar.gz && \
  mv /postgres_exporter-0.9.0.linux-amd64/postgres_exporter /postgres_exporter && \
  chmod +x /postgres_exporter

COPY queries.yaml /etc/queries.yaml

RUN chmod 0444 /etc/queries.yaml

CMD /postgres_exporter --extend.query-path /etc/queries.yaml --log.level debug --exclude-databases template0,template1,postgres

