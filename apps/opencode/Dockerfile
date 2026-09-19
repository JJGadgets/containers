FROM docker.io/library/debian:13.6@sha256:f324c7ff54321e8d9c588493a20244965938ce0aa50bbd1022d38010e9ffc4b1
# Define build-time variables
USER 0:0
ENV BUN_RUNTIME_TRANSPILER_CACHE_PATH=0
RUN apt update && apt install --yes --no-install-suggests --no-install-recommends ca-certificates build-essential procps curl file git gcc && rm -rf /var/lib/apt /var/cache
RUN useradd --uid 1000 --home-dir /home/openclaw --create-home --user-group openclaw

USER 1000:1000
WORKDIR /app
ARG VERSION
# ARG TARGETARCH
RUN curl -vLo ./app.tar.gz "https://github.com/anomalyco/opencode/releases/download/v${VERSION}/opencode-linux-x64.tar.gz" && tar -xvf ./app.tar.gz && rm ./app.tar.gz && chmod 555 ./opencode

VOLUME ["/home/openclaw"]
WORKDIR /home/openclaw
ENTRYPOINT ["/app/opencode"]
# users to provide their own config file, no default provided
