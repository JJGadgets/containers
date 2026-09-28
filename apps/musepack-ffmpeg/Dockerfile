# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/archlinux:base@sha256:b21322c663be387c0ed9cbc7bbbfe18e41633ad4e7b7c77cfad45f128be20040

USER root:root
RUN --mount=type=cache,sharing=locked,target=/var/cache/pacman \
    pacman -Syu --noconfirm --needed musepack-tools jellyfin-ffmpeg catatonit fish

USER nobody:nogroup
WORKDIR /

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c"]
CMD ["sleep infinity"]
