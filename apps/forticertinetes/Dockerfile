FROM alpine:3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659
ARG VERSION
USER nobody:nogroup
WORKDIR /app
RUN apk add --no-cache catatonit kubectl openssh-client
COPY --chown=nobody:nogroup --chmod=555 ./apps/forticertinetes/forticertinetes.sh /app/forticertinetes.sh

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c", "/app/forticertinetes.sh"]

# # Renovate changelogs
# LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
