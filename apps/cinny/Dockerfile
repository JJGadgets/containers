ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.6@sha256:9f89bd238c9c0239aa51a29d88edc00c689d485dbd9b053fb412ae3b98de29fe
COPY --chown=65534:65534 --chmod=444 --from=upstream /app /app
COPY --chown=65534:65534 --chmod=555 ./apps/cinny/Caddyfile /Caddyfile

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile"]
LABEL org.opencontainers.image.source="https://github.com/cinnyapp/cinny"
