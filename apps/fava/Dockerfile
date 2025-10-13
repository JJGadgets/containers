# Stage 1: install app to venv
FROM docker.io/library/debian:12 AS builder
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv
USER 65534:65534
WORKDIR /app
ARG VERSION
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir fava[excel]==$VERSION

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:1a7c3d2445f783c51be174c8913624dc5bea2cd7ff1f94b9a229a16f0e40fa34
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
