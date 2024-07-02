FROM ghcr.io/jjgadgets/caddy-distroless-base:2.8.4@sha256:f130eb49ed3455a715e0142be5c4e6e30a5c894c57040d20f348dfbbe6aee360
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
