ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.20@sha256:31687a2fdd021f85955bf2d0c2682e9c0949827560e1db546358ea094f740f12
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/usr/sbin/bird", "-d", "-f"]
