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

ADD https://raw.githubusercontent.com/objectbox/objectbox-go/main/install.sh objectbox-install.sh
RUN chmod u+x objectbox-install.sh \
      && ./objectbox-install.sh

RUN go mod download && go mod verify
RUN go build -o /fmd cmd/fmdserver.go

# Stage 2: Working app image
FROM gcr.io/distroless/static-debian12:nonroot@sha256:39ae7f0201fee13b777a3e4a5a9326a8889269172c8b4f4289d9f19c831f45f4
ARG VERSION
WORKDIR /fmd

ADD --chmod=555 --chown=1000:1000 --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit
COPY --from=builder /fmd /fmd/server
COPY --from=builder /usr/lib/libobjectbox.so /usr/lib/libobjectbox.so
COPY --from=builder /go/src/findmydeviceserver-${VERSION}/web /fmd/web
COPY --from=builder /go/src/findmydeviceserver-${VERSION}/extra /fmd/extra

USER 1000:1000
WORKDIR /fmd/objectbox
WORKDIR /fmd
# port 8080 used in >0.4.0 (or master), port 1020 used in <=0.4.0
EXPOSE 8080/tcp
EXPOSE 1020/tcp
VOLUME ["/fmd/objectbox"]
ENTRYPOINT ["/catatonit", "--", "/fmd/server"]

