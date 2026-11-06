FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.9@sha256:cef1ab6062a14670ebe10eda74de3fbe569cf2af8d3911e8b80a958d1add24eb
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
