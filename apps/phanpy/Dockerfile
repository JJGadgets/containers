FROM public.ecr.aws/docker/library/busybox:1.36.1@sha256:650fd573e056b679a5110a70aabeb01e26b76e545ec4b9c70a9523f2dfaf18c6 AS upstream
ARG VERSION
USER 1000:1000
WORKDIR /app
RUN wget -qO- https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.zip | unzip -

FROM ghcr.io/jjgadgets/caddy-distroless-base:rolling
COPY --from=upstream /app /app

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
