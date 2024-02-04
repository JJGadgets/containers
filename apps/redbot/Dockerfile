# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/python:3.11.7-slim-bookworm AS builder
ARG VERSION
WORKDIR /app

RUN python3 -m venv /app
ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"
RUN /app/bin/pip install --no-cache-dir --upgrade pip wheel
ARG VERSION
# RUN /app/bin/pip install --no-cache-dir --upgrade Red-DiscordBot[postgres]==${VERSION}

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:02c3a74bee78c927ab39dd739f0e56e36675e6adc9032208abb7ed8b83067c74
WORKDIR /app

COPY --from=builder /app /app
COPY --chmod=555 --chown=1000:1000 ./apps/redbot/entrypoint.py /app/entrypoint.py

RUN /app/bin/pip install --no-cache-dir --upgrade Red-DiscordBot[postgres]==${VERSION}

# ENV VIRTUAL_ENV=/app
# ENV PATH="/app/bin:$PATH"

# ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit

USER 1000:1000
VOLUME ["/config"]
# ENTRYPOINT ["/catatonit", "--", "/app/bin/python3", "/app/bin/entrypoint.py"]
ENTRYPOINT ["python3", "/app/entrypoint.py"]
