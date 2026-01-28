ARG VERSION

# Stage 1: Install webhook
FROM public.ecr.aws/docker/library/alpine:3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659 AS builder
WORKDIR /
ARG TARGETARCH

ADD https://github.com/adnanh/webhook/releases/latest/download/webhook-linux-${TARGETARCH}.tar.gz /webhook.tar.gz
RUN tar -xvf /webhook.tar.gz && mv /webhook-linux-${TARGETARCH}/webhook /webhook

# Stage 2: Working app image
# FROM gcr.io/distroless/static-debian12:nonroot@sha256:dcd3f1f09adef5689088c9c4d96a8d98c889d8281d3946145074f89eafe7e1af
ARG VERSION
FROM ghcr.io/siderolabs/talosctl:v${VERSION}
WORKDIR /app

ADD --chmod=555 --chown=nobody:nogroup --checksum=sha256:af8a43230338de67563878a25872ee2fd3d6af0f3513d55dd1ec672ad69dae53 https://github.com/openSUSE/catatonit/releases/download/v0.2.0/catatonit.x86_64 /catatonit
COPY --chmod=555 --chown=nobody:nogroup --from=builder /webhook /app/webhook
COPY --chmod=555 --chown=nobody:nogroup ./apps/talosctl-image-pull-agent/hooks.yaml /app/hooks.yaml

USER nobody:nogroup
EXPOSE 9000/tcp
ENTRYPOINT ["/catatonit", "--", "/app/webhook"]
CMD ["-verbose", "-hooks", "/app/hooks.yaml"]
