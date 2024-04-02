# Define build-time variables
ARG VERSION
# for GoToSocial, the image we are copying from already has multi-arch support, so no need to specify TARGETPLATFORM or ARCH here

# Stage 1: Define upstream GoToSocial image to copy from
FROM docker.io/superseriousbusiness/gotosocial:${VERSION} AS upstream

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:e9ac71e2b8e279a8372741b7a0293afda17650d926900233ec3a7b2b7c22a246
WORKDIR /gotosocial
COPY --chown=1000:1000 --from=upstream /gotosocial /gotosocial

USER 1000:1000
VOLUME ["/gotosocial/storage"]
ENTRYPOINT ["/gotosocial/gotosocial"]
CMD ["server", "start"]

LABEL org.opencontainers.image.source="https://github.com/superseriousbusiness/gotosocial"
