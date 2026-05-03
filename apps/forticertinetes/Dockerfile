FROM alpine:3.23.4@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11
USER root
RUN apk add --no-cache catatonit kubectl openssh-client
ARG VERSION
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=555 ./apps/forticertinetes/forticertinetes.sh /app/forticertinetes.sh

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c", "/app/forticertinetes.sh"]

# # Renovate changelogs
# LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
