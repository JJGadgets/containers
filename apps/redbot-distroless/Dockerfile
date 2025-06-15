# Define build-time variables
ARG VERSION
FROM ghcr.io/jjgadgets/redbot:${VERSION}@sha256:77fdb8aa315f39e6ce89c2ff027526ec0acea170673279e2599f88596d81b852 AS builder

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:b34be7bbfb23377f7600f53c7110df970fdd50d2e57aad7091e45056f7907eaf
USER 1000:1000
WORKDIR /config
WORKDIR /app

COPY --chmod=555 --chown=1000:1000 --from=builder /app /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

USER 1000:1000
ENV BASE_PATH=/config
ENV XDG_CONFIG_HOME=/config/config
VOLUME ["/config"]
ENTRYPOINT ["/app/bin/redbot"]
CMD ["--init"]