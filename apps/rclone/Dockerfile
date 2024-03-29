# Define build-time variables
ARG VERSION
# for GoToSocial, the image we are copying from already has multi-arch support, so no need to specify TARGETPLATFORM or ARCH here

# Stage 1: Define upstream GoToSocial image to copy from
FROM docker.io/rclone/rclone:${VERSION} AS upstream

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:67686c9070e7179449c73943d89160c4834c0b4a969434022e11c5b9a8dc6131
COPY --chown=1000:1000 --from=upstream /usr/local/bin/rclone /rclone
COPY --from=upstream /etc/fuse.conf /etc/fuse.conf
ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit

USER 1000:1000
ENV XDG_CONFIG_HOME=/config
WORKDIR /data
VOLUME ["/data"]
ENTRYPOINT ["/catatonit", "--", "/rclone"]
CMD ["version"]
