ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:7a16fbac33728694301f18b5414dd257e9f2902fc0d1d5c8919bf86c73b93570
COPY --chown=65534:65534 --chmod=444 --from=upstream /app /app
COPY --chown=65534:65534 --chmod=555 ./apps/cinny/Caddyfile /Caddyfile

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile"]
LABEL org.opencontainers.image.source="https://github.com/cinnyapp/cinny"
