FROM alpine:3.24.4@sha256:93b41ef40b1677fce8fcc64ff4af09daddfacf5040afde618bc46c1e2d1cc7d4
USER root
RUN apk add --no-cache catatonit kubectl openssh-client
ARG VERSION
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=555 ./apps/forticertinetes/forticertinetes.sh /app/forticertinetes.sh

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c", "/app/forticertinetes.sh"]

# # Renovate changelogs
# LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
