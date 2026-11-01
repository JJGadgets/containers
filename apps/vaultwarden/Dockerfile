ARG VERSION
FROM ghcr.io/dani-garcia/vaultwarden:${VERSION} AS upstream

FROM gcr.io/distroless/static-debian13:nonroot@sha256:25ac8f0c3b2334a9eb05452266bd4697864a8c8ef0ef71e5e6480d7f92868329
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
