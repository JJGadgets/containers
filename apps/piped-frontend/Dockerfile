ARG VERSION

FROM docker.io/1337kavin/piped-frontend:latest@sha256:1ce67163448941627a2abc51a1d622120331d8e55ef78b85a83dc2de8811616e AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:b8211840edf949089b31a6b6912b8f3ef82cf853836dde1db1a3ac970ac5e293
COPY --chown=65534:65534 --chmod=555 --from=upstream /usr/share/nginx/html/ /app
COPY --chown=65534:65534 --chmod=555 ./apps/piped-frontend/Caddyfile /Caddyfile

USER 65534:65534
EXPOSE 8080/tcp
CMD ["run", "--config", "/Caddyfile"]
