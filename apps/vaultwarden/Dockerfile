ARG VERSION
FROM ghcr.io/dani-garcia/vaultwarden:${VERSION} AS upstream

FROM gcr.io/distroless/static-debian13:nonroot@sha256:f512d819b8f109f2375e8b51d8cfd8aafe81034bc3e319740128b7d7f70d5036
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=444 --from=upstream /web-vault /app/web-vault
COPY --chown=nobody:nogroup --chmod=555 /vaultwarden /app/vaultwarden

ENV ROCKET_PROFILE="release" \
    ROCKET_ADDRESS=:: \
    ROCKET_PORT=8080 \
    SSL_CERT_DIR=/etc/ssl/certs

ENTRYPOINT ["/app/vaultwarden"]

LABEL org.opencontainers.image.source="https://github.com/dani-garcia/vaultwarden"
