# Define build-time variables
ARG VERSION
FROM ghcr.io/jjgadgets/redbot:${VERSION}@sha256:77fdb8aa315f39e6ce89c2ff027526ec0acea170673279e2599f88596d81b852 AS builder

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:60a4160404e92c4e5639166c303cca6f5081e1110a09261aeaec38d36f539c6d
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