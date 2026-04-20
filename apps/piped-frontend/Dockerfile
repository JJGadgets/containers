ARG VERSION

FROM docker.io/1337kavin/piped-frontend:latest@sha256:7ccda9646bfde6dd19f7e63f2f1c791b801aa9b8f23e9da33bb9e51d3c7c5d47 AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:b8211840edf949089b31a6b6912b8f3ef82cf853836dde1db1a3ac970ac5e293
COPY --chown=65534:65534 --chmod=555 --from=upstream /usr/share/nginx/html/ /app
COPY --chown=65534:65534 --chmod=555 ./apps/piped-frontend/Caddyfile /Caddyfile

USER 65534:65534
EXPOSE 8080/tcp
CMD ["run", "--config", "/Caddyfile"]
