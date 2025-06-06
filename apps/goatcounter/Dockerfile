# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM public.ecr.aws/docker/library/alpine:3.19.0 AS builder
ARG VERSION
ARG TARGETARCH

ADD https://github.com/arp242/goatcounter/releases/download/v${VERSION}/goatcounter-v${VERSION}-linux-${TARGETARCH}.gz /goatcounter.gz
RUN gzip -d /goatcounter.gz

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:dcd3f1f09adef5689088c9c4d96a8d98c889d8281d3946145074f89eafe7e1af
ARG VERSION
WORKDIR /app

ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit
COPY --from=builder --chmod=555 /goatcounter /app/goatcounter

USER 1000:1000
EXPOSE 8080/tcp
VOLUME ["/data", "/tmp"]
ENV TMPDIR=/tmp
WORKDIR /data
ENTRYPOINT ["/catatonit", "--", "/app/goatcounter"]
CMD ["serve", "-automigrate", "-listen=:8080", "-tls=proxy", "-db=sqlite+/data/db/goatcounter.sqlite3", "-smtp=stdout", "-email-from=goatcounter@localhost"]
