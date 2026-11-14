# syntax=docker/dockerfile:1.7
# check=error=true

ARG VERSION

# Stage 1: Fetch and verify the published bundle.
FROM docker.io/library/node:24.22.3-trixie-slim@sha256:af02d57b57719b9657a45199a79264a9437940cd55b3c7b3fc99615654f124a0 AS package

ARG VERSION
USER 1000:1000
WORKDIR /home/node

# No installation scripts or dependency installation.
RUN npm pack --ignore-scripts --silent --pack-destination /tmp \
    "mindwtr-mcp@${VERSION}"

# Perform package and ESM checks without network access.
RUN --network=none set -eu; \
    mkdir -p /tmp/mindwtr; \
    tar -xzf "/tmp/mindwtr-mcp-${VERSION}.tgz" \
        -C /tmp/mindwtr --strip-components=1; \
    node -e 'const p=require("/tmp/mindwtr/package.json"); if(p.name!=="mindwtr-mcp" || p.version!==process.argv[1] || Object.keys(p.dependencies||{}).length) process.exit(1)' "${VERSION}"; \
    test -s /tmp/mindwtr/dist/index.js; \
    test -s /tmp/mindwtr/dist/cli.js; \
    node --check /tmp/mindwtr/dist/index.js; \
    node --check /tmp/mindwtr/dist/cli.js; \
    node --input-type=module -e 'await import("/tmp/mindwtr/dist/index.js")'

# Stage 2: Minimal distroless runtime.
FROM gcr.io/distroless/nodejs24-debian13:nonroot@sha256:9eeb7f5887d0e239e78264b06f7f11d2e14be534050481803a9e4728fcdd278e

ARG VERSION
WORKDIR /app

# Copy only the necessary runtime files.
# Files remain root-owned and non-writable.
COPY --from=package --chown=0:0 --chmod=0444 /tmp/mindwtr/package.json /app/package.json
COPY --from=package --chown=0:0 --chmod=0444 /tmp/mindwtr/dist/index.js /app/dist/index.js
COPY --from=package --chown=0:0 --chmod=0444 /tmp/mindwtr/dist/cli.js /app/dist/cli.js

ENV NODE_ENV=production \
    NODE_OPTIONS=--no-addons \
    HOME=/tmp \
    MINDWTR_MCP_HTTP=true \
    MINDWTR_MCP_HTTP_HOST=0.0.0.0 \
    MINDWTR_MCP_HTTP_PORT=8722

USER 65532:65532

# Node.js is the distroless image's inherited ENTRYPOINT.
# Read-only Streamable HTTP is the default.
CMD ["/app/dist/cli.js", "--http"]

LABEL org.opencontainers.image.source="https://github.com/dongdongbh/Mindwtr"

