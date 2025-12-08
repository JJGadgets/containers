FROM docker.io/continuumio/miniconda3:24.11.1-0@sha256:6a66425f001f739d4778dd732e020afeb06175f49478fafc3ec673658d61550b
USER 1000:1000
WORKDIR /app

USER 0:0
RUN \
--mount=type=cache,target=/var/tmp,sharing=locked \
--mount=type=cache,target=/tmp,sharing=locked \
conda init && conda create --yes --copy -p /app python=3.11 && conda install --yes --freeze-installed -p /app -c conda-forge git-lfs tini gcc gxx_linux-64 && conda clean -afy

ARG VERSION
ARG CHANNEL
RUN \
--mount=type=cache,target=/var/tmp,sharing=locked \
--mount=type=cache,target=/tmp,sharing=locked \
case "${CHANNEL}" in \
  "nightly") export PACKAGES_TO_INSTALL="mlc-llm-nightly-cpu mlc-ai-nightly-cpu"; export CONDA_TO_INSTALL="-c conda-forge libvulkan-loader" ;; \
  "stable") export PACKAGES_TO_INSTALL="mlc-llm-cpu>=${VERSION:=0.0.0} mlc-ai-cpu>=${VERSION:=0.0.0}"; export CONDA_TO_INSTALL="-c conda-forge libvulkan-loader" ;; \
  "cuda-nightly") export PACKAGES_TO_INSTALL="mlc-llm-nightly-cu123 mlc-ai-nightly-cu123"; export CONDA_TO_INSTALL="-c nvidia cuda-nvcc" ;; \
  "cuda") export PACKAGES_TO_INSTALL="mlc-llm-cu123>=${VERSION:=0.0.0} mlc-ai-cu123>=${VERSION:=0.0.0}"; export CONDA_TO_INSTALL="-c nvidia cuda-nvcc" ;; \
  *) echo 'NO PACKAGES TO INSTALL! Aborting.' && exit 1 ;; \
esac && \
conda run -p /app python -m pip install --no-cache-dir --pre -U -vv --force-reinstall -f https://mlc.ai/wheels ${PACKAGES_TO_INSTALL} && \
conda install --yes --freeze-installed -p /app ${CONDA_TO_INSTALL} && \
conda clean -afy

# Phi 3.5 Vision
RUN \
--mount=type=cache,target=/var/tmp,sharing=locked \
--mount=type=cache,target=/tmp,sharing=locked \
conda run -p /app python -m pip install --no-cache-dir --pre -U -vv --force-reinstall Pillow && \
conda clean -afy

ARG TARGETARCH
RUN \
--mount=type=cache,target=/var/cache/apt,sharing=locked \
--mount=type=cache,target=/var/lib/apt,sharing=locked \
set -o allexport && . /etc/os-release && set +o allexport && \
# case "${CHANNEL}" in \
#   cuda*) \
#     apt-key del 7fa2af80 || true; \
#     # apt update && apt install --yes --no-install-recommends software-properties-common && apt-add-repository contrib -y && apt purge --yes software-properties-common && \
#     wget "https://developer.download.nvidia.com/compute/cuda/repos/${ID}${VERSION_ID}/$(uname -m)/cuda-keyring_1.1-1_all.deb" && apt install ./cuda-keyring_1.1-1_all.deb || exit 1; rm -rf ./cuda-keyring_1.1-1_all.deb; \
#     apt update && apt install --yes --no-install-recommends cuda-toolkit gcc g++ && apt clean \
#   ;; \
#   *) \
    echo "deb http://deb.debian.org/debian ${VERSION_CODENAME}-backports main" >> /etc/apt/sources.list && \
    apt update && apt install -t ${VERSION_CODENAME}-backports --yes --no-install-recommends mesa-vulkan-drivers vulkan-tools; \
  # ;; \
# esac && \
apt clean && rm -rf /tmp/* /var/tmp/

USER 1000:1000
WORKDIR /data
ENV VIRTUAL_ENV="/app"
ENV PATH="/app/bin:$PATH:/usr/local/cuda/bin:/usr/lib/gcc/x86_64-linux-gnu/12"
ENV LD_LIBRARY_PATH="/app/lib/python3.11/site-packages/nvidia/cuda_nvrtc/lib:/app/lib/python3.11/site-packages/nvidia/cuda_runtime/lib:/app/lib/python3.11/site-packages/nvidia/cublas/lib:/usr/local/cuda/lib64"
ENV PWD="/data"
ENV HOME="/data"
VOLUME ["/data"]
ENTRYPOINT ["/app/bin/tini", "-g", "--", "/app/bin/mlc_llm", "serve", "--host", "", "--port", "8080"]
# CMD (or `args` on K8s) used to specify model and additional args
