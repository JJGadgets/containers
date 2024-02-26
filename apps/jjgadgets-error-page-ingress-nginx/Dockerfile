FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:ab907452cd544cb2af3fb7d55d9db367c36e6618a9aabc0a44e2692f764d00e1
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
