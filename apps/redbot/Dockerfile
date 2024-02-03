# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/python:3.12.1-slim-bookworm AS builder
ARG VERSION
WORKDIR /app

RUN python3 -m venv /app
ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip wheel
ARG VERSION
RUN pip install --no-cache-dir --upgrade "Red-DiscordBot[postgres]==${VERSION}"

# Stage 2: Working app image
#FROM gcr.io/distroless/cc-debian12:nonroot@sha256:6cf8f0fafa8b4b911eefa9be9e2fe40fcf380f56de25d203dd9a3782c255d1f3
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:02c3a74bee78c927ab39dd739f0e56e36675e6adc9032208abb7ed8b83067c74
WORKDIR /app

COPY --from=builder /app /app
COPY ./apps/redbot/entrypoint.py /app/bin/entrypoint.py

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit

USER 1000:1000
VOLUME ["/config"]
ENTRYPOINT ["/catatonit", "--", "/app/bin/entrypoint.py"]
