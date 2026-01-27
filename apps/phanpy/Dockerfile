FROM ghcr.io/nicolaka/netshoot:v0.12@sha256:b569665f0c32391b93f4de344f07bf6353ddff9d8c801ac3318d996db848a64c AS upstream
ARG VERSION
USER 1000:1000
WORKDIR /app
RUN curl -vL https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.zip | busybox unzip -

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:b8211840edf949089b31a6b6912b8f3ef82cf853836dde1db1a3ac970ac5e293
COPY --from=upstream /app /app

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
