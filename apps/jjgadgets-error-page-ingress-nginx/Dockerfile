FROM ghcr.io/jjgadgets/caddy-distroless-base:2.10.2@sha256:4b40d15700bd96173bf072a71048de33c69ad24881e30afd28f07806ad2eef3e
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
