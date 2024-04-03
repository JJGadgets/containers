ARG VERSION

FROM public.ecr.aws/docker/library/debian:12.2-slim
ARG VERSION
RUN apt update && apt install -y samba=${VERSION} ctdb=${VERSION} winbind=${VERSION} samba-vfs-modules=${VERSION} catatonit && apt clean && rm -rf /var/lib/apt/lists && rm -rf /var/cache
# TODO: if CephFS kernel mount (PVC) not working as expected, switch to Debian unstable and install libcephfs2 for vfs_ceph, all other Debian versions are wildly out of date

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--", "/usr/sbin/smbd"]
CMD ["--foreground", "--no-process-group"]
