FROM public.ecr.aws/docker/library/busybox:1.36.1@sha256:c3839dd800b9eb7603340509769c43e146a74c63dca3045a8e7dc8ee07e53966 AS upstream
ARG VERSION
USER 1000:1000
WORKDIR /app
RUN curl -vL https://github.com/cheeaun/phanpy/releases/download/${VERSION}/phanpy-dist.zip | unzip -

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:7a16fbac33728694301f18b5414dd257e9f2902fc0d1d5c8919bf86c73b93570
COPY --from=upstream /app /app

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["file-server", "--root", "/app", "--listen", ":8080"]
LABEL org.opencontainers.image.source="https://github.com/cheeaun/phanpy"
