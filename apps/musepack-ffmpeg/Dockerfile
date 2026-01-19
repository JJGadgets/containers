# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/archlinux:base
USER root:root
RUN pacman -Syyu musepack-tools jellyfin-ffmpeg catatonit
USER nobody:nogroup

ENTRYPOINT ["catatonit", "--", "/bin/sh", "-c"]
CMD ["sleep infinity"]
