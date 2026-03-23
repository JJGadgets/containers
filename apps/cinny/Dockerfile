ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:b8211840edf949089b31a6b6912b8f3ef82cf853836dde1db1a3ac970ac5e293
COPY --chown=65534:65534 --chmod=444 --from=upstream /app /app
COPY --chown=65534:65534 --chmod=555 ./apps/cinny/Caddyfile /Caddyfile

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile"]
LABEL org.opencontainers.image.source="https://github.com/cinnyapp/cinny"
