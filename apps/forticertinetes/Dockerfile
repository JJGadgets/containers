FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a
USER root
RUN apk add --no-cache catatonit kubectl openssh-client
ARG VERSION
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=555 ./apps/forticertinetes/forticertinetes.sh /app/forticertinetes.sh

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c", "/app/forticertinetes.sh"]

# # Renovate changelogs
# LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
