FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.4@sha256:59ddd212f5680d4e39239bee7cc037a19dc9782fcc8b1f5fbe342cd96abc6d06
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
