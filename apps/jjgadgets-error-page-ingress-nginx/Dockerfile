FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.5@sha256:12a2721d89fda5f8266ee7912941cd9743f45ff58bbac2b2cee7854ddcc3ad79
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
