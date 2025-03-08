FROM ghcr.io/jjgadgets/caddy-distroless-base:2.9.1@sha256:651fac98c1794ce3bd2cef1a7dc3ff3e61157718ce3781aa218b6167cbfb182c
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
