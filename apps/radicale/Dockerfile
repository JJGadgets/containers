
# Stage 1: install app to venv
FROM docker.io/library/debian:12.6@sha256:aadf411dc9ed5199bc7dab48b3e6ce18f8bbee4f170127f5ff1b75cd8035eb36 AS builder
# Define build-time variables
ARG VERSION
USER 0:0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends python3-venv git
USER 1000:1000
WORKDIR /app
RUN python3 -m venv . && /app/bin/pip install --upgrade --no-cache-dir radicale==$VERSION passlib[bcrypt] git+https://github.com/pvagner/radicale-auth-ldap.git@c9c9f7db9e6cff6f1cb2d4cd8dafa89d43cecdd1
# above plugin hash is from "3" branch

# Stage 2: Working app image
FROM gcr.io/distroless/python3-debian12:nonroot@sha256:10998541893f872cc9c9c4ed4cb2c1446f47e02221c4448a865e8ab24c55f7c2
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
