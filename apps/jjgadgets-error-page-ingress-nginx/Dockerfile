FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:e0fd046bd906dbe86bdec7d9551f22aaeea6b65bb765bd8fb6b81042950af1e0
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
