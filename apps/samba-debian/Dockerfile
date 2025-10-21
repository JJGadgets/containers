FROM public.ecr.aws/docker/library/debian:13.1-slim@sha256:66b37a5078a77098bfc80175fb5eb881a3196809242fd295b25502854e12cbec
ARG PKGVER
RUN apt update && apt install -y samba=${PKGVER} ctdb=${PKGVER} winbind=${PKGVER} samba-vfs-modules=${PKGVER} catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache
# TODO: if CephFS kernel mount (PVC) not working as expected, switch to Debian unstable and install libcephfs2 for vfs_ceph, all other Debian versions are wildly out of date

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/smbd"]
CMD ["--foreground", "--no-process-group"]
