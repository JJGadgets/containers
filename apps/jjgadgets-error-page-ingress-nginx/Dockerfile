FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:fd79c124231375140323e7827757136ab7b8671db2407d22fdfa5f012f8d2bab
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
