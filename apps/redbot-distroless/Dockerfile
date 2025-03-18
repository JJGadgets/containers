# Define build-time variables
ARG VERSION
FROM ghcr.io/jjgadgets/redbot:${VERSION}@sha256:77fdb8aa315f39e6ce89c2ff027526ec0acea170673279e2599f88596d81b852 AS builder

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:a30940339541f1628b873c1f6926e2516650009a84058c68255ef7ff204080aa
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