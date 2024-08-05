FROM ghcr.io/nicolaka/netshoot:v0.12@sha256:b569665f0c32391b93f4de344f07bf6353ddff9d8c801ac3318d996db848a64c AS upstream
ARG VERSION
USER 1000:1000
WORKDIR /app
RUN curl -vL https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.zip | busybox unzip -

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.8.4@sha256:e0a07a7dff8ee21e768d3c36a5ca3e64092fc5d8b11743b59cddeba95e037201
COPY --from=upstream /app /app

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
