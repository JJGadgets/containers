FROM public.ecr.aws/docker/library/debian:13.3-slim@sha256:77ba0164de17b88dd0bf6cdc8f65569e6e5fa6cd256562998b62553134a00ef0
ARG PKGVER
RUN apt update && apt install -y samba=${PKGVER} ctdb=${PKGVER} winbind=${PKGVER} samba-vfs-modules=${PKGVER} catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache
# TODO: if CephFS kernel mount (PVC) not working as expected, switch to Debian unstable and install libcephfs2 for vfs_ceph, all other Debian versions are wildly out of date

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/smbd"]
CMD ["--foreground", "--no-process-group"]
