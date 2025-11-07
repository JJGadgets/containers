ARG VERSION

FROM docker.io/1337kavin/piped-frontend:latest@sha256:72316c7009b841f45939beb6946bbba2343b66a12e256d61346521b415e3c438 AS upstream

FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:4b40d15700bd96173bf072a71048de33c69ad24881e30afd28f07806ad2eef3e
COPY --chown=65534:65534 --chmod=555 --from=upstream /usr/share/nginx/html/ /app
COPY --chown=65534:65534 --chmod=555 ./apps/piped-frontend/Caddyfile /Caddyfile

USER 65534:65534
CMD ["run", "--config", "/Caddyfile"]
