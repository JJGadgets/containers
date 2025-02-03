# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM ghcr.io/astral-sh/uv:0.5.26 AS build
USER 1000:1000
WORKDIR /install
WORKDIR /app
ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_PYTHON_INSTALL_DIR=/install
RUN uv venv /app
ARG VERSION
ADD git@github.com:JJGadgets/FortiDynaSync#${VERSION}:uv.lock /app/uv.lock
RUN uv sync --frozen --no-install-project
ADD git@github.com:JJGadgets/FortiDynaSync#${VERSION} /app
RUN uv sync --frozen

FROM gcr.io/distroless/static-debian12:nonroot
USER 1000:1000
COPY --from=build /install /install
COPY --from=build /app /app
WORKDIR /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

ENTRYPOINT ["/app/bin/python3", "/app/fortigate-dhcp-dns-sync.py"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/JJGadgets/fortigate-dhcp-dns-sync"
