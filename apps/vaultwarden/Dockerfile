ARG VERSION
FROM ghcr.io/dani-garcia/vaultwarden:${VERSION} AS upstream

FROM gcr.io/distroless/static-debian13:nonroot@sha256:8ce6dd87e9823c5b48dcfb2c8604714ccb351ce59607327bcc4957448da279b5
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=444 --from=upstream /web-vault /app/web-vault
COPY --chown=nobody:nogroup --chmod=555 --from=upstream /vaultwarden /app/vaultwarden

ENV ROCKET_PROFILE="release" \
    ROCKET_ADDRESS=:: \
    ROCKET_PORT=8080 \
    SSL_CERT_DIR=/etc/ssl/certs

ENTRYPOINT ["/app/vaultwarden"]

LABEL org.opencontainers.image.source="https://github.com/dani-garcia/vaultwarden"
