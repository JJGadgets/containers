ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.23@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/usr/sbin/bird", "-d", "-f"]
