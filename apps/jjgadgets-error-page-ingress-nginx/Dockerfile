FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:955abfb2490893116494aeb2326aa6f90ab9338624b033ac743bd7ff50585edb
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
