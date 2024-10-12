FROM docker.io/continuumio/miniconda3:24.7.1-0@sha256:f37f8c7db26ae7ec0098df530e96c9cde139026b9faf3914800d1522c47a49b1
USER 1000:1000
WORKDIR /app

USER 0:0
RUN \
--mount=type=cache,target=/var/tmp,sharing=locked \
--mount=type=cache,target=/tmp,sharing=locked \
conda init && conda create --yes --copy -p /app python=3.11 && conda install --yes --freeze-installed -p /app -c conda-forge git-lfs tini gcc libvulkan-loader && conda clean -afy

ARG VERSION
ARG CHANNEL
RUN \
--mount=type=cache,target=/var/tmp,sharing=locked \
--mount=type=cache,target=/tmp,sharing=locked \
if [ "${CHANNEL}" = "nightly" ]; then \
  export PACKAGES_TO_INSTALL="mlc-llm-nightly-cpu mlc-ai-nightly-cpu"; \
elif [ "${VERSION}" != "stable" ]; then \
  export PACKAGES_TO_INSTALL="mlc-llm-cpu>=${VERSION:=0.0.0} mlc-ai-cpu>=${VERSION:=0.0.0}"; \
if [ "${CHANNEL}" = "cuda-nightly" ]; then \
  export PACKAGES_TO_INSTALL="mlc-llm-nightly-cu123 mlc-ai-nightly-cu123"; \
elif [ "${VERSION}" != "cuda" ]; then \
  export PACKAGES_TO_INSTALL="mlc-llm-cu123>=${VERSION:=0.0.0} mlc-ai-cu123>=${VERSION:=0.0.0}"; \
fi ; \
conda run -p /app python -m pip install --no-cache-dir --pre -U -vv --force-reinstall -f https://mlc.ai/wheels ${PACKAGES_TO_INSTALL} && \
conda clean -afy

RUN \
--mount=type=cache,target=/var/cache/apt,sharing=locked \
--mount=type=cache,target=/var/lib/apt,sharing=locked \
set -o allexport && . /etc/os-release && set +o allexport && \
echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" >> /etc/apt/sources.list && \
apt update && apt install -t ${VERSION_CODENAME}-backports -y mesa-vulkan-drivers vulkan-tools && apt clean && rm -rf /tmp/* /var/tmp/

USER 1000:1000
WORKDIR /data
ENV VIRTUAL_ENV="/app"
ENV PATH="/app/bin:$PATH"
ENV PWD="/data"
ENV HOME="/data"
VOLUME ["/data"]
ENTRYPOINT ["/app/bin/tini", "-g", "--", "/app/bin/mlc_llm", "serve", "--host", "", "--port", "8080"]
# CMD (or `args` on K8s) used to specify model and additional args
