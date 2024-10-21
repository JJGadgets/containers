FROM ghcr.io/jjgadgets/caddy-distroless-base:2.8.4@sha256:0f91f5e9dba2e44d4e6960c3e0157c6858fdb72fc5081de5d622dd8f39e0b6cb
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
