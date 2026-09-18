ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.4@sha256:59ddd212f5680d4e39239bee7cc037a19dc9782fcc8b1f5fbe342cd96abc6d06
COPY --chown=65534:65534 --chmod=444 --from=upstream /app /app
COPY --chown=65534:65534 --chmod=555 ./apps/cinny/Caddyfile /Caddyfile

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile"]
LABEL org.opencontainers.image.source="https://github.com/cinnyapp/cinny"
