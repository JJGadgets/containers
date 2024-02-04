# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/python:3.11.7-slim-bookworm
ARG VERSION
USER 1000:1000
WORKDIR /app

RUN python3 -m venv /app
ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"
RUN /app/bin/pip install --no-cache-dir --upgrade pip wheel
ARG VERSION
RUN /app/bin/pip install --no-cache-dir --upgrade Red-DiscordBot[postgres]==${VERSION}
COPY --chmod=555 --chown=1000:1000 ./apps/redbot/entrypoint.py /app/entrypoint.py

USER 1000:1000
VOLUME ["/config"]
ENTRYPOINT ["python3", "/app/entrypoint.py"]
