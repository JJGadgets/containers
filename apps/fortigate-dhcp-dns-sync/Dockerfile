# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM debian:12-slim AS build
RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes python3-venv gcc libpython3-dev
USER 1000:1000
WORKDIR /app
RUN python3 -m venv /app && \
    /app/bin/pip install --upgrade pip setuptools wheel

FROM gcr.io/distroless/python3-debian12:nonroot@sha256:e575731d90afa06f113d94beedb526f56c9a7cb38612c608ff211bb8efc09572

USER 1000:1000
COPY --from=build /app /app
WORKDIR /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"
RUN /app/bin/pip install --no-cache-dir --upgrade requests typing
COPY --chmod=555 --chown=1000:1000 ./apps/fortigate-dhcp-dns-sync/fortigate-dhcp-dns-sync.py /app/fortigate-dhcp-dns-sync.py

ENTRYPOINT ["/app/bin/python3", "/app/fortigate-dhcp-dns-sync.py"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/JJGadgets/fortigate-dhcp-dns-sync"
