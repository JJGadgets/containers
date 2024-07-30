# Define build-time variables
ARG VERSION

FROM docker.io/library/node:lts-alpine AS base
# Stage 1: clone Elk repo
FROM base AS git
RUN apk update
RUN apk add --no-cache git
WORKDIR /build
ARG VERSION
RUN git clone --depth 1 --branch "v${VERSION}" https://github.com/elk-zone/elk /build
# Stage 2: Build Elk (taken from upstream Elk Dockerfile)
FROM base AS builder
RUN apk update
RUN apk add --no-cache git
## Set compile-time env vars (this is for my use, so will point to my GoToSocial instance)
ENV NUXT_PUBLIC_DEFAULT_SERVER=social.jjgadgets.tech
ENV NUXT_PUBLIC_SINGLE_INSTANCE=true
ENV NUXT_PUBLIC_DISABLE_VERSION_CHECK=true
## Prepare work directory
WORKDIR /elk
## Prepare pnpm https://pnpm.io/installation#using-corepack
RUN corepack enable
## Prepare build deps ( ignore postinstall scripts for now )
COPY --from=git /build/package.json ./
COPY --from=git /build/.npmrc ./
COPY --from=git /build/pnpm-lock.yaml ./
COPY --from=git /build/patches ./patches
RUN pnpm i --frozen-lockfile --ignore-scripts
## Copy all source files
COPY --from=git /build/. ./
## Run full install with every postinstall script ( This needs project file )
RUN pnpm i --frozen-lockfile
## Build
RUN pnpm build

# Stage 2: Working app image
FROM gcr.io/distroless/nodejs20-debian12:nonroot@sha256:e681c52c13235593aa35896e0940ca3737c358af13611b762081f7af42e5462b
WORKDIR /elk/data
WORKDIR /elk
COPY --chown=42069:42069 --from=builder /elk/.output /elk/.output

ENV PORT=5314
ENV NODE_ENV=production
ENV NUXT_STORAGE_DRIVER=fs
ENV NUXT_STORAGE_FS_BASE='/elk/data'

## set the same compile-time env vars at runtime, though I'm not sure if they actually work at runtime
ENV NUXT_PUBLIC_DEFAULT_SERVER=social.jjgadgets.tech
ENV NUXT_PUBLIC_SINGLE_INSTANCE=true
ENV NUXT_PUBLIC_DISABLE_VERSION_CHECK=true

EXPOSE 5314/tcp
USER 42069:42069
VOLUME ["/elk/data"]
ENTRYPOINT ["/nodejs/bin/node"]
CMD ["/elk/.output/server/index.mjs"]
