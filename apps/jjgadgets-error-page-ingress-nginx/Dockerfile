FROM ghcr.io/jjgadgets/caddy-distroless-base:2.11.6@sha256:9f89bd238c9c0239aa51a29d88edc00c689d485dbd9b053fb412ae3b98de29fe
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
