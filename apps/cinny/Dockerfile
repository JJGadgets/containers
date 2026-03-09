ARG VERSION
FROM ghcr.io/cinnyapp/cinny:v${VERSION} AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:7a16fbac33728694301f18b5414dd257e9f2902fc0d1d5c8919bf86c73b93570
COPY --from=upstream /app /app

USER nobody:nogroup
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
