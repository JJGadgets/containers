FROM docker.io/continuumio/miniconda3:24.7.1-0@sha256:f37f8c7db26ae7ec0098df530e96c9cde139026b9faf3914800d1522c47a49b1
USER 1000:1000
WORKDIR /app

USER 0:0
RUN conda init && conda create --yes --copy -p /app python=3.11 && conda install --yes -p /app -c conda-forge git-lfs tini && conda clean -afy && rm -rf /tmp/*
RUN conda install --yes --freeze-installed -p /app -c conda-forge gcc libvulkan-loader && conda clean -afy && rm -rf /tmp/*
# TODO: optimize above install command
ARG VERSION
RUN bash -c '[[ "${VERSION}" == "rolling" ]] && export PACKAGES_TO_INSTALL="mlc-llm-nightly-cpu mlc-ai-nightly-cpu" || [[ "${VERSION}" != "rolling" ]] && export PACKAGES_TO_INSTALL="mlc-llm-cpu>=${VERSION:=0.0.0} mlc-ai-cpu>=${VERSION:=0.0.0}"; \
conda run -p /app python -m pip install --no-cache-dir --pre -U -vv --force-reinstall -f https://mlc.ai/wheels ${PACKAGES_TO_INSTALL} && \
conda clean -afy && rm -rf /tmp/*'
RUN apt update && apt install -y mesa-va-drivers mesa-vulkan-drivers vulkan-tools && apt clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache /var/tmp/

USER 1000:1000
WORKDIR /data
ENV VIRTUAL_ENV="/app"
ENV PATH="/app/bin:$PATH"
ENV PWD="/data"
ENV HOME="/data"
VOLUME ["/data"]
ENTRYPOINT ["/app/bin/tini", "-g", "--", "/app/bin/mlc_llm", "serve", "--host", "", "--port", "8080"]
# CMD (or `args` on K8s) used to specify model and additional args
