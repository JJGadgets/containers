FROM docker.io/continuumio/miniconda3:24.7.1-0@sha256:f37f8c7db26ae7ec0098df530e96c9cde139026b9faf3914800d1522c47a49b1
USER 1000:1000
WORKDIR /app

USER 0:0
RUN conda init && conda create --yes --copy -p /app python=3.11 && conda install --yes -p /app -c conda-forge git-lfs tini && conda run -p /app python -m pip install --no-cache-dir --pre -U -f https://mlc.ai/wheels mlc-llm-nightly-cpu mlc-ai-nightly-cpu && conda clean -afy && rm -rf /tmp/*
RUN conda install --yes --freeze-installed -p /app -c conda-forge gcc libvulkan-loader && conda clean -afy
RUN apt update && apt install -y mesa-va-drivers mesa-vulkan-drivers && apt clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/

USER 1000:1000
ENV VIRTUAL_ENV="/app"
ENV PATH="/app/bin:$PATH"
ENV PWD="/app"
ENV HOME="/app"
VOLUME ["/app/.tvm_test_data", "/app/.cache"]
ENTRYPOINT ["/app/bin/tini", "-g", "--", "/app/bin/mlc_llm", "serve", "--host", "", "--port", "8080"]
# CMD (or `args` on K8s) used to specify model and additional args
