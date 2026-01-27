FROM public.ecr.aws/docker/library/debian:12.13-slim@sha256:56ff6d36d4eb3db13a741b342ec466f121480b5edded42e4b7ee850ce7a418ee
ARG PKGVER
RUN apt update && apt install -y samba=${PKGVER} ctdb=${PKGVER} winbind=${PKGVER} samba-vfs-modules=${PKGVER} catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache
# TODO: if CephFS kernel mount (PVC) not working as expected, switch to Debian unstable and install libcephfs2 for vfs_ceph, all other Debian versions are wildly out of date

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/smbd"]
CMD ["--foreground", "--no-process-group"]
