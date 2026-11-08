FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf
USER root
RUN apk add --no-cache catatonit kubectl openssh-client
ARG VERSION
USER nobody:nogroup
WORKDIR /app
COPY --chown=nobody:nogroup --chmod=555 ./apps/forticertinetes/forticertinetes.sh /app/forticertinetes.sh

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c", "/app/forticertinetes.sh"]

# # Renovate changelogs
# LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
