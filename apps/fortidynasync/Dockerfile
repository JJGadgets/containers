# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM scratch AS git
# FROM ghcr.io/astral-sh/uv:0.5.26-debian-slim AS git
ARG VERSION
ADD --chown=1000:1000 https://github.com/JJGadgets/FortiDynaSync.git#${VERSION} /git
# RUN ls -AlhR /git
# RUN apt update && apt install -y --no-install-recommends git ca-certificates && git clone https://github.com/JJGadgets/FortiDynaSync /git/FortiDynaSync.git

FROM ghcr.io/astral-sh/uv:0.5.26-debian-slim AS build
USER 1000:1000
WORKDIR /app
ENV UV_NO_CACHE=true
ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1
ENV UV_PYTHON_INSTALL_DIR=/app/python-install
COPY --from=git --chown=1000:1000 /git/.python-version /app/.python-version
COPY --from=git --chown=1000:1000 /git/pyproject.toml /app/pyproject.toml
COPY --from=git --chown=1000:1000 /git/uv.lock /app/uv.lock
RUN uv venv
RUN uv sync --frozen --no-install-project
COPY --from=git --chown=1000:1000 /git /app
RUN uv sync --frozen
RUN ls -AlhR /app
RUN du -sh /app

FROM gcr.io/distroless/cc-debian12:nonroot
USER 1000:1000
COPY --from=build /app /app
WORKDIR /app

ENV VIRTUAL_ENV=/app/.venv
ENV PATH="/app/.venv/bin:$PATH"

ENTRYPOINT ["/app/.venv/bin/python3", "/app/fortidynasync.py"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/JJGadgets/fortidynasync"
