FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:fca1cc8feeaeb231903c84fd88c004a23f717e3f1abbaadad6cfbfb3ce5739fb
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
