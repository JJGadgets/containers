# Stage 1: Define upstream GoToSocial image to copy from
FROM docker.io/joplin/server:3.3.9-beta@sha256:4b57f0b5cea3ba3bbe52fed3354fea032e7c1bb0e2e5d452005037c572539280 AS upstream

# Stage 2: Working app image
## check node version from https://github.com/laurent22/joplin/blob/80c2a87da20dbf7a7fc34b451d4234805a3d51a0/Dockerfile.server#L56
FROM gcr.io/distroless/nodejs18-debian12:nonroot@sha256:911dcabc3e26de44d14f8db90a9f3611b505a0db8a6cbb0d32ecba40a80ae7f5

ARG upstreamuser=joplin
WORKDIR /joplin
COPY --chown=1000:1000 --chmod=555 --from=upstream /usr/local/bin/yarn /nodejs/bin/yarn
COPY --chown=1000:1000 --from=upstream /home/$upstreamuser/packages /joplin

WORKDIR /joplin/server
ENV NODE_ENV=production
ENV RUNNING_IN_DOCKER=1
ENV APP_PORT=22300
USER 1000:1000
ENTRYPOINT ["/nodejs/bin/yarn"]
CMD ["start-prod"]
