ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.20@sha256:a4f4213abb84c497377b8544c81b3564f313746700372ec4fe84653e4fb03805
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/usr/bin/catatonit", "--"]
CMD ["/usr/sbin/bird", "-d", "-f"]
