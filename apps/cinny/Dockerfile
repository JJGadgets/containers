ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.7@sha256:01a81e7625a2ee73af0a3c88da65545dc7ce0037a5a3cad486430584ad1d4ece
COPY --chown=65534:65534 --chmod=444 --from=upstream /app /app
COPY --chown=65534:65534 --chmod=555 ./apps/cinny/Caddyfile /Caddyfile

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile"]
LABEL org.opencontainers.image.source="https://github.com/cinnyapp/cinny"
