# Define build-time variables
ARG VERSION

# Stage 1: Build (pulled from upstream Dockerfile https://github.com/botlabs-gg/yagpdb/blob/7e6d553bd203680a0a1d68afd94f815478538611/yagpdb_docker/Dockerfile)
FROM docker.io/library/golang:1.21.6-bookworm AS builder
ARG VERSION

ADD https://github.com/botlabs-gg/yagpdb/archive/refs/tags/v${VERSION}.tar.gz /source.tar.gz
RUN tar -C /go/src -xvf /source.tar.gz
RUN rm /source.tar.gz

WORKDIR /go/src/yagpdb-${VERSION}
ENV GOPATH /go

# require Postgres TLS (to be used in Kubernetes with Postgres operators that automagically manage TLS)
# Golang's pq doesn't support sslmode=prefer :/ (https://github.com/lib/pq/issues/776)
RUN grep -Rl 'sslmode=disable' . | xargs -I% /bin/bash -c "sed -i 's/sslmode=disable/sslmode=require/g' %"
RUN grep -Rl 'sslmode="disable"' . | xargs -I% /bin/bash -c "sed -i 's/sslmode=\"disable\"/sslmode=\"require\"/g' %"

RUN go mod download && go mod verify
WORKDIR /go/src/yagpdb-${VERSION}/cmd/yagpdb
RUN CGO_ENABLED=0 GOOS=linux go build -o /yagpdb -v -ldflags="-X github.com/botlabs-gg/yagpdb/v2/common.VERSION=v${VERSION}"

# Stage 2: Working app image
#FROM gcr.io/distroless/cc-debian12:nonroot@sha256:6cf8f0fafa8b4b911eefa9be9e2fe40fcf380f56de25d203dd9a3782c255d1f3
FROM gcr.io/distroless/static-debian12:nonroot@sha256:8dd8d3ca2cf283383304fd45a5c9c74d5f2cd9da8d3b077d720e264880077c65
ARG VERSION
WORKDIR /app

ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit
COPY --from=builder /yagpdb /app/yagpdb

USER 1000:1000
EXPOSE 5000/tcp
VOLUME ["/app/soundboard"]
ENTRYPOINT ["/catatonit", "--", "/app/yagpdb"]
CMD ["-all", "-ts", "-exthttps=true", "-https=false"]
