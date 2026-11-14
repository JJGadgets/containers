# syntax=docker/dockerfile:1.7@sha256:a57df69d0ea827fb7266491f2813635de6f17269be881f696fbfdf2d83dda33e
# Build fully static Musepack SV8 CLI binaries (musl libc) for the target Linux architecture.
# The single final scratch image includes binaries under /usr/local/bin and license notices.
ARG ALPINE_VERSION=3.23

ARG CONTEXT=.

FROM alpine:${ALPINE_VERSION} AS build

RUN apk add --no-cache \
      autoconf \
      automake \
      bash \
      binutils \
      build-base \
      bison \
      ca-certificates \
      cmake \
      coreutils \
      curl \
      flex \
      libtool \
      make \
      patch \
      pkgconf-dev \
      tar

ARG MUSEPACK_SHA256=a4b1742f997f83e1056142d556a8c20845ba764b70365ff9ccf2e3f81c427b2b
ARG LIBCUE_SHA256=cc1b3a65c60bd88b77a1ddd1574042d83cf7cc32b85fe9481c99613359eb7cfe
ARG REPLAYGAIN_SHA256=8258bf785547ac2cda43bb195e07522f0a3682f55abe97753c974609ec232482

ENV DEPS_PREFIX=/opt/musepack-deps \
    SOURCE_DATE_EPOCH=1630000000 \
    TZ=UTC
WORKDIR /src

# Pin upstream source archives by SHA-256. libcue and libreplaygain are built as static archives.
RUN set -eux; \
    curl --fail --show-error --location --retry 3 --proto '=https' --tlsv1.2 \
      https://files.musepack.net/source/musepack_src_r475.tar.gz -o /tmp/musepack.tar.gz; \
    echo "${MUSEPACK_SHA256}  /tmp/musepack.tar.gz" | sha256sum -c -; \
    curl --fail --show-error --location --retry 3 --proto '=https' --tlsv1.2 \
      https://github.com/lipnitsk/libcue/archive/refs/tags/v2.3.0.tar.gz -o /tmp/libcue.tar.gz; \
    echo "${LIBCUE_SHA256}  /tmp/libcue.tar.gz" | sha256sum -c -; \
    curl --fail --show-error --location --retry 3 --proto '=https' --tlsv1.2 \
      https://files.musepack.net/source/libreplaygain_r475.tar.gz -o /tmp/replaygain.tar.gz; \
    echo "${REPLAYGAIN_SHA256}  /tmp/replaygain.tar.gz" | sha256sum -c -; \
    mkdir -p /src/musepack /src/libcue /src/libreplaygain; \
    tar -xzf /tmp/musepack.tar.gz --strip-components=1 -C /src/musepack; \
    tar -xzf /tmp/libcue.tar.gz --strip-components=1 -C /src/libcue; \
    tar -xzf /tmp/replaygain.tar.gz --strip-components=1 -C /src/libreplaygain; \
    rm -f /tmp/musepack.tar.gz /tmp/libcue.tar.gz /tmp/replaygain.tar.gz

# CMake 4 rejects these projects' pre-3.0 minimums. Raise only the declared minimum;
# no project logic is changed. BUILD_SHARED_LIBS=OFF makes both dependencies static.
RUN set -eux; \
    sed -E -i 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9.]+/CMAKE_MINIMUM_REQUIRED(VERSION 3.10/' /src/libcue/CMakeLists.txt; \
    sed -E -i 's/CMAKE_MINIMUM_REQUIRED\(VERSION [0-9.]+/CMAKE_MINIMUM_REQUIRED(VERSION 3.10/' /src/libreplaygain/CMakeLists.txt; \
    cmake -S /src/libcue -B /src/libcue/build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${DEPS_PREFIX}" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5; \
    cmake --build /src/libcue/build --parallel; \
    cmake --install /src/libcue/build; \
    cmake -S /src/libreplaygain -B /src/libreplaygain/build \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="${DEPS_PREFIX}" \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5; \
    cmake --build /src/libreplaygain/build --parallel; \
    cmake --install /src/libreplaygain/build; \
    test -f "${DEPS_PREFIX}/lib/libcue.a"; \
    test -f "${DEPS_PREFIX}/lib/libreplaygain.a"

# Apply the Arch Linux package's compatibility patches before regenerating Autotools.
ARG CONTEXT=.
COPY ${CONTEXT}/patches/ /patches/
RUN set -eux; \
    cd /src/musepack; \
    for p in \
      01_am-maintainer-mode.patch \
      02_link-libm.patch \
      03_mpcchap.patch \
      04_link-order.patch \
      04_link-order-mpcenc.patch \
      05_visibility.patch \
      1001_missing_extern_kw.patch \
      add_subdir-objects.patch \
      06_gcc14-incompatible-pointers.patch \
      07_musl-compat.patch \
      08_libcue-file-api.patch; do \
        patch --batch --forward --ignore-whitespace -Np1 -i "/patches/${p}"; \
    done; \
    mv configure.in configure.ac; \
    autoreconf --force --install

# Keep Autoconf's compiler probe on normal driver flags. At build time, pass Libtool's
# -all-static option (not -static, which only selects static Libtool libraries). The
# final ELF checks enforce that every installed executable is genuinely statically linked.
RUN set -eux; \
    cd /src/musepack; \
    export PKG_CONFIG_PATH="${DEPS_PREFIX}/lib/pkgconfig"; \
    export CPPFLAGS="-I${DEPS_PREFIX}/include"; \
    export CFLAGS="-Os -fno-pie"; \
    export LDFLAGS="-no-pie -L${DEPS_PREFIX}/lib"; \
    export LIBS="-lm"; \
    if ! ./configure \
      --prefix=/usr/local \
      --enable-mpcchap \
      --disable-shared \
      --enable-static; then \
        cat config.log >&2; \
        exit 1; \
    fi; \
    make --jobs="$(nproc)" LDFLAGS="-all-static -no-pie -L${DEPS_PREFIX}/lib"; \
    make DESTDIR=/stage LDFLAGS="-all-static -no-pie -L${DEPS_PREFIX}/lib" install; \
    test -d /stage/usr/local/bin; \
    test -n "$(find /stage/usr/local/bin -maxdepth 1 -type f -perm /111 -print -quit)"; \
    for bin in /stage/usr/local/bin/*; do \
      [ -f "$bin" ] || continue; \
      [ -x "$bin" ] || continue; \
      if readelf -l "$bin" | grep -q 'INTERP'; then \
        echo "ERROR: $bin has a dynamic ELF interpreter" >&2; exit 1; \
      fi; \
      if readelf -d "$bin" 2>/dev/null | grep -q 'NEEDED'; then \
        echo "ERROR: $bin has dynamic shared-library dependencies" >&2; exit 1; \
      fi; \
      set +e; "$bin" --help >/tmp/musepack-smoke.log 2>&1; status=$?; set -e; \
      if [ "$status" -ge 128 ]; then \
        cat /tmp/musepack-smoke.log >&2; \
        echo "ERROR: $bin failed to execute (status $status)" >&2; exit 1; \
      fi; \
    done; \
    mkdir -p /stage/usr/share/licenses/musepack-static/musepack \
      /stage/usr/share/licenses/musepack-static/libcue \
      /stage/usr/share/licenses/musepack-static/libreplaygain; \
    find /src/musepack -maxdepth 3 -type f \( -iname 'COPYING*' -o -iname 'LICENSE*' \) \
      -exec cp -n '{}' /stage/usr/share/licenses/musepack-static/musepack/ \;; \
    find /src/libcue -maxdepth 2 -type f \( -iname 'COPYING*' -o -iname 'LICENSE*' \) \
      -exec cp -n '{}' /stage/usr/share/licenses/musepack-static/libcue/ \;; \
    find /src/libreplaygain -maxdepth 2 -type f \( -iname 'COPYING*' -o -iname 'LICENSE*' \) \
      -exec cp -n '{}' /stage/usr/share/licenses/musepack-static/libreplaygain/ \;; \
    find /stage/usr/local/bin -maxdepth 1 -type f -perm /111 -print | sort

# Single final image works as a standalone tools image, a COPY --from source, or an
# ImageVolume. In an ImageVolume mounted at /tools, commands live under /tools/usr/local/bin.
FROM scratch
COPY --from=build /stage/usr/local/bin/ /usr/local/bin/
COPY --from=build /stage/usr/share/licenses/musepack-static/ /usr/share/licenses/musepack-static/
ENV PATH="/usr/local/bin:${PATH}"
