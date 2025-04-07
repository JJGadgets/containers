# Stage 1: install app to venv
FROM docker.io/library/debian:12 AS builder
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv
USER 65534:65534
WORKDIR /app
ARG VERSION
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir fava[excel]==$VERSION

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:b0ae47130fa7633d6599a320610230310ff5126307e3a3a6acf7de3fd6931f94
USER 65534:65534
WORKDIR /data

COPY --chmod=555 --chown=1000:1000 --from=builder /app /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

USER 65534:65534
VOLUME ["/data"]
ENTRYPOINT ["/app/bin/fava"]
ENV BEANCOUNT_FILE=/data/default.beancount
ENV FAVA_HOST=::
