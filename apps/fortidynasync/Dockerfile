# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM scratch AS git
ARG VERSION
ADD --chown=1000:1000 https://github.com/JJGadgets/FortiDynaSync.git#${VERSION} /git

FROM ghcr.io/astral-sh/uv:0.5.26-debian-slim@sha256:5ad2072d1f547eaee5ef5e68666c63198c9153f3d5ad9beef8aa094ba1510030 AS build
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

FROM gcr.io/distroless/cc-debian12:nonroot@sha256:189bd2ce1f7750193c2c10220d9201ba38c11e30fbb75b036606829fadbc81b1
USER 1000:1000
COPY --from=build /app /app
WORKDIR /app

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"

ENTRYPOINT ["/app/.venv/bin/python3", "/app/fortidynasync.py"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/JJGadgets/FortiDynaSync"
