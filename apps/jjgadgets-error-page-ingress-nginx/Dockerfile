FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:f3d02d310c0cab9ef72b69f950f3ef1296527e18bfa8d26ea193f90d00416022
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
