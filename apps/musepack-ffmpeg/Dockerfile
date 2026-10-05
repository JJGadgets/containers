# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/archlinux:base@sha256:4e77cf2ea5f410e6f8be5abf93ccf17ce2436e87a138c167208356711a405dbd

USER root:root
RUN --mount=type=cache,sharing=locked,target=/var/cache/pacman \
    pacman -Syu --noconfirm --needed musepack-tools jellyfin-ffmpeg catatonit fish

USER nobody:nogroup
WORKDIR /

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c"]
CMD ["sleep infinity"]
