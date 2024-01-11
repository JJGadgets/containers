ARG VERSION

FROM public.ecr.aws/docker/library/alpine:3.19.0
ARG VERSION
RUN apk add bird=${VERSION}
RUN apk add catatonit

USER 0:0
ENTRYPOINT ["/catatonit"]
CMD ["/bird", "-d"]
