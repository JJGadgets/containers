FROM ghcr.io/astral-sh/uv:0.4.16-bookworm-slim
WORKDIR /app
ENV VIRTUAL_ENV="/app"
ENV PATH="/python/bin:/app/bin:$PATH"
ENV UV_CACHE_DIR="/var/cache/uv"
ENV UV_LINK_MODE="copy"
ENV UV_PYTHON_INSTALL_DIR="/python/bin"
RUN \
--mount=type=cache,target=/var/cache/apt,sharing=locked \
--mount=type=cache,target=/var/lib/apt,sharing=locked \
apt update && \
apt install --yes --no-install-recommends ca-certificates python3-minimal tini git-lfs libvulkan1 mesa-vulkan-drivers && \
apt purge --yes python3 python3.11 && apt clean && rm -rf /tmp/* /var/tmp/
RUN \
--mount=type=cache,target=/var/cache/uv \
uv venv --python 3.11 /app
RUN \
--mount=type=cache,target=/var/cache/uv \
uv pip install --prerelease=allow -U -f https://mlc.ai/wheels mlc-llm-nightly-cpu mlc-ai-nightly-cpu && \
rm -rf /tmp/* /var/tmp/

USER 1000:1000
WORKDIR /data
ENV VIRTUAL_ENV="/app"
ENV PATH="/python/bin:/app/bin:$PATH"
ENV PWD="/data"
ENV HOME="/data"
VOLUME ["/data"]
ENTRYPOINT ["tini", "-g", "--", "/app/bin/mlc_llm", "serve", "--host", "", "--port", "8080"]
# CMD (or `args` on K8s) used to specify model and additional args
