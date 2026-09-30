FROM public.ecr.aws/docker/library/debian:13.7-slim@sha256:a99cfc517144bc59b1978475ec53b46ecabec7e43635402ee5b77cc54cd1b20a
ARG PKGVER
RUN apt update && apt install -y samba=${PKGVER} ctdb=${PKGVER} winbind=${PKGVER} samba-vfs-modules=${PKGVER} catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache
# TODO: if CephFS kernel mount (PVC) not working as expected, switch to Debian unstable and install libcephfs2 for vfs_ceph, all other Debian versions are wildly out of date

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/smbd"]
CMD ["--foreground", "--no-process-group"]
