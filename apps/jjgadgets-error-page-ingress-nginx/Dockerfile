FROM ghcr.io/jjgadgets/caddy-distroless-base:2.8.4@sha256:e0a07a7dff8ee21e768d3c36a5ca3e64092fc5d8b11743b59cddeba95e037201
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
