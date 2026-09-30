ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/usr/sbin/bird", "-d", "-f"]
