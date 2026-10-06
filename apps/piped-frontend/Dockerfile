ARG VERSION

FROM docker.io/1337kavin/piped-frontend:latest@sha256:72316c7009b841f45939beb6946bbba2343b66a12e256d61346521b415e3c438 AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.7@sha256:01a81e7625a2ee73af0a3c88da65545dc7ce0037a5a3cad486430584ad1d4ece
COPY --chown=65534:65534 --chmod=555 --from=upstream /usr/share/nginx/html/ /app
COPY --chown=65534:65534 --chmod=555 ./apps/piped-frontend/Caddyfile /Caddyfile

USER 65534:65534
EXPOSE 8080/tcp
CMD ["run", "--config", "/Caddyfile"]
