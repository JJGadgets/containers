FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.7@sha256:01a81e7625a2ee73af0a3c88da65545dc7ce0037a5a3cad486430584ad1d4ece
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
