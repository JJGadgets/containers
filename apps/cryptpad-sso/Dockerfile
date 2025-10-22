# Stage 1: Build
FROM scratch AS git
ARG VERSION
WORKDIR /cryptpad/lib/plugins
ADD --chown=4001:4001 https://github.com/cryptpad/sso.git#${VERSION} /cryptpad/lib/plugins/sso

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/cryptpad/sso"
