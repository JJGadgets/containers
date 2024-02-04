# Define build-time variables
ARG VERSION
FROM ghcr.io/jjgadgets/redbot:${VERSION} AS builder

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:02c3a74bee78c927ab39dd739f0e56e36675e6adc9032208abb7ed8b83067c74
USER 1000:1000
WORKDIR /app

COPY --chmod=555 --chown=1000:1000 --from=builder /app /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

# ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit

USER 1000:1000
VOLUME ["/config"]
# ENTRYPOINT ["/catatonit", "--", "/app/bin/python3", "/app/bin/entrypoint.py"]
ENTRYPOINT ["python3", "/app/entrypoint.py"]
