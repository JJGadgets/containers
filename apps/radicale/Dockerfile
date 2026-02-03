
# Stage 1: install app to venv
FROM docker.io/library/debian:13.3@sha256:2c91e484d93f0830a7e05a2b9d92a7b102be7cab562198b984a84fdbc7806d91 AS builder
# Define build-time variables
ARG VERSION
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv git
USER 1000:1000
WORKDIR /app
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir radicale==$VERSION passlib[bcrypt] git+https://github.com/pvagner/radicale-auth-ldap.git@c9c9f7db9e6cff6f1cb2d4cd8dafa89d43cecdd1
# above plugin hash is from "3" branch

# Stage 2: Install Jujutsu
FROM docker.io/library/alpine:3.20.1 AS jj
RUN busybox wget -O- https://github.com/martinvonz/jj/releases/download/v0.19.0/jj-v0.19.0-x86_64-unknown-linux-musl.tar.gz | busybox tar -xvf -

# Stage 3: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:e575731d90afa06f113d94beedb526f56c9a7cb38612c608ff211bb8efc09572
USER 1000:1000
WORKDIR /data
WORKDIR /config
WORKDIR /app

COPY --chmod=555 --chown=1000:1000 --from=builder /app /app

ENV VIRTUAL_ENV=/app
ENV PATH="/app/bin:$PATH"

USER 1000:1000
VOLUME ["/data"]
ENTRYPOINT ["/app/bin/radicale"]
CMD ["--config", "/config/config"]
# users to provide their own config file, no default provided
