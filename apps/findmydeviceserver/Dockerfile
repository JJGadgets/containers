# Define build-time variables
ARG VERSION
# for GoToSocial, the image we are copying from already has multi-arch support, so no need to specify TARGETPLATFORM or ARCH here

# Stage 1: Build FindMyDeviceServer (pulled from upstream Dockerfile https://gitlab.com/Nulide/findmydeviceserver/-/blob/6bfd5c8ed285474aa225a56da96b51f9d0bddb58/Dockerfile#L1-L16)
FROM docker.io/library/golang:1.21.6-bookworm AS builder
ARG VERSION

ADD https://gitlab.com/Nulide/findmydeviceserver/-/archive/${VERSION}/findmydeviceserver-${VERSION}.tar.gz /source.tar.gz
RUN tar -C /go/src -xvf /source.tar.gz

WORKDIR /go/src/findmydeviceserver-${VERSION}
ENV GOPATH /go

RUN go mod download && go mod verify
RUN go build -o /fmd cmd/fmdserver.go

# Stage 2: Working app image
FROM gcr.io/distroless/cc-debian12:nonroot@sha256:7e5b8df2f4d36f5599ef4ab856d7d444922531709becb03f3368c6d797d0a5eb
# FROM debian:12
ARG VERSION
WORKDIR /fmd

ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit
COPY --from=builder /fmd /fmd/server
COPY --from=builder /go/src/findmydeviceserver-${VERSION}/web /fmd/web
COPY --from=builder /go/src/findmydeviceserver-${VERSION}/extra /fmd/extra

USER nobody:nogroup
WORKDIR /data
# port 8080 used in >0.4.0 (or master), port 1020 used in <=0.4.0
EXPOSE 8080/tcp
ENV FMD_DATABASEDIR=/data/db
ENV FMD_WEBDIR=/fmd/web
ENV FMD_PORTINSECURE=8080
ENTRYPOINT ["/catatonit", "--", "/fmd/server"]
CMD ["serve"]
