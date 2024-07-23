
# Stage 1: install app to venv
FROM docker.io/library/debian:12.6@sha256:45f2e735295654f13e3be10da2a6892c708f71a71be845818f6058982761a6d3 AS builder
# Define build-time variables
ARG VERSION
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv git
USER 1000:1000
WORKDIR /app
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir radicale==$VERSION passlib[bcrypt] git+https://github.com/pvagner/radicale-auth-ldap.git@c9c9f7db9e6cff6f1cb2d4cd8dafa89d43cecdd1
# above plugin hash is from "3" branch

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:e35fc9d1378fa456ee8de1ccdfd697382b267609f6f253bddd23170ae5583d71
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
