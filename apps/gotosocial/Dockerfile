# Define build-time variables
ARG VERSION
# for GoToSocial, the image we are copying from already has multi-arch support, so no need to specify TARGETPLATFORM or ARCH here

# Stage 1: Define upstream GoToSocial image to copy from
FROM docker.io/superseriousbusiness/gotosocial:${VERSION} AS upstream

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:6efcd31f942dfa1e39e53a168ad537f85c7db8073e7b68a308a51d440b2d64ff
WORKDIR /gotosocial
COPY --chown=1000:1000 --from=upstream /gotosocial /gotosocial

USER 1000:1000
VOLUME ["/gotosocial/storage"]
ENTRYPOINT ["/gotosocial/gotosocial"]
CMD ["server", "start"]

LABEL org.opencontainers.image.source="https://github.com/superseriousbusiness/gotosocial"
