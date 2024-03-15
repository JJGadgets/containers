FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:6b425b3938b7d8efebd9294c5a719e1700f089fb74fb70e24b38786a5cf52ef9
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
