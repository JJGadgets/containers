ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/usr/sbin/bird", "-d", "-f"]
