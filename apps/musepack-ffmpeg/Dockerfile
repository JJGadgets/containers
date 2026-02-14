# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/archlinux:base@sha256:644b416048d39616bbaca93ce768ba492655c83fba80ceca65a4f59dcabdcac0

USER root:root
RUN --mount=type=cache,sharing=locked,target=/var/cache/pacman \
    pacman -Syu --noconfirm --needed musepack-tools jellyfin-ffmpeg catatonit fish

USER nobody:nogroup
WORKDIR /

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c"]
CMD ["sleep infinity"]
