FROM ghcr.io/jjgadgets/caddy-distroless-base:2.7.6@sha256:c7772c85f1df238d393a7c362c2d1d9c4f9ac02c19d22fd2ab2c7b245c3fcf55
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/error.html /web/error.html
COPY --chown=1000:1000 --chmod=555 ./apps/jjgadgets-error-page-ingress-nginx/Caddyfile /Caddyfile

USER 1000:1000
ENTRYPOINT ["/caddy"]
CMD ["run", "--config", "/Caddyfile", "--adapter", "caddyfile"]
