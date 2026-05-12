# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM scratch AS git
ARG VERSION
ADD --chown=1000:1000 https://github.com/JJGadgets/FortiDynaSync.git#${VERSION} /git

FROM ghcr.io/astral-sh/uv:0.11.14-debian-slim@sha256:2702577da32d9c3d55c8073e07d4476cd7402c085efbf71921104548c851d96a AS build
USER 1000:1000
WORKDIR /app
ENV UV_NO_CACHE=true
# ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_NO_INSTALLER_METADATA=1
ENV UV_PYTHON_INSTALL_DIR=/app/python-install
COPY --from=git --chown=1000:1000 /git/.python-version /git/pyproject.toml /git/uv.lock /app/
RUN uv venv
RUN uv sync --frozen --no-install-project --no-editable
COPY --from=git --chown=1000:1000 /git /app
RUN uv sync --frozen --no-editable && ls -AlhR /app

FROM gcr.io/distroless/cc-debian12:nonroot
USER 1000:1000
COPY --from=build /app /app
WORKDIR /app

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"

ENTRYPOINT ["/app/.venv/bin/python3", "/app/fortidynasync.py"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
