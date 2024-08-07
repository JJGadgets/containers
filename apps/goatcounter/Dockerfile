# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM public.ecr.aws/docker/library/alpine:3.19.0 AS builder
ARG VERSION
ARG TARGETARCH

ADD https://github.com/arp242/goatcounter/releases/download/v${VERSION}/goatcounter-v${VERSION}-linux-${TARGETARCH}.gz /goatcounter.gz
RUN gzip -d /goatcounter.gz

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:8dd8d3ca2cf283383304fd45a5c9c74d5f2cd9da8d3b077d720e264880077c65
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
CMD ["serve", "-automigrate", "-listen=:8080", "-tls=proxy", "-db=sqlite+file:/data/db/goatcounter.sqlite3?_journal_mode=wal&_busy_timeout=200&_cache_size=-20000", "-smtp=stdout", "-email-from=goatcounter@localhost"]
