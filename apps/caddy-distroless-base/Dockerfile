# Define build-time variables
ARG VERSION

# Stage 1 (Build): Build Caddy with xcaddy builder image
FROM public.ecr.aws/docker/library/caddy:${VERSION}-builder AS builder
RUN xcaddy build

# Stage 2 (App): Use Google's distroless Debian 12 static non-root image as base image for actual app image, and copy compiled Caddy binary
FROM gcr.io/distroless/static-debian12:nonroot@sha256:39ae7f0201fee13b777a3e4a5a9326a8889269172c8b4f4289d9f19c831f45f4
COPY --chown=1000:1000 --chmod=555 --from=builder /usr/bin/caddy /caddy
# NOTE: This base image flavour won't set the setcap for NET_BIND_SERVICE yet, so that the fileserver image flavour can launch by default on :8080 without any Linux capabilities
# Refer to `jjgadgets/caddy` image for a Caddy image that runs on privileged ports (<1024, Caddy uses :80 for HTTP and :443 for HTTPS by default)

# Stage 2 (App): create Caddy's expected directories with WORKDIR and point Caddy to them with XDG env vars
WORKDIR /config/rendered
WORKDIR /config/data
WORKDIR /config
ENV XDG_CONFIG_HOME /config/rendered
ENV XDG_DATA_HOME /config/data

USER 1000:1000
ENTRYPOINT ["/caddy"]
# NOTE: no `CMD` here, other image flavours will have the `CMD` set
