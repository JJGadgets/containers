# Stage 1: install app to venv
FROM docker.io/library/debian:12@sha256:aadf411dc9ed5199bc7dab48b3e6ce18f8bbee4f170127f5ff1b75cd8035eb36 AS builder
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv
USER 1000:1000
WORKDIR /app
ARG VERSION
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir "huggingface_hub==$VERSION"

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:e575731d90afa06f113d94beedb526f56c9a7cb38612c608ff211bb8efc09572
USER 1000:1000
WORKDIR /app

COPY --chmod=555 --chown=1000:1000 --from=builder /app /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

USER 1000:1000
ENTRYPOINT ["/app/bin/hf"]
