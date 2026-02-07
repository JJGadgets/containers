# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM scratch AS git
USER 1000:1000

WORKDIR /
ARG VERSION
ADD --chown=1000:1000 --chmod=555 https://github.com/yt-dlp/yt-dlp/releases/download/${VERSION}/yt-dlp /yt-dlp

ENTRYPOINT ["/yt-dlp"]

# Renovate changelogs
LABEL org.opencontainers.image.source="https://github.com/yt-dlp/yt-dlp"
