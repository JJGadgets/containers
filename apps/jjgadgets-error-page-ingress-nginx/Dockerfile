FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.0@sha256:3a447270074aeca9f0c4a65ad93c1877cbede939bae05c0a0e5c6a2b7cdd1e04
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
