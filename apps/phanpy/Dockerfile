FROM ghcr.io/nicolaka/netshoot:v0.12@sha256:b569665f0c32391b93f4de344f07bf6353ddff9d8c801ac3318d996db848a64c AS upstream
ARG VERSION
USER 1000:1000
WORKDIR /app
RUN curl -vL https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.zip | busybox unzip -

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:7a16fbac33728694301f18b5414dd257e9f2902fc0d1d5c8919bf86c73b93570
COPY --from=upstream /app /app

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
