# Static Musepack SV8 CLI tools

This Dockerfile builds the upstream Musepack SV8 r475 command-line tools as fully statically linked Linux executables using musl libc. It applies the Arch Linux compatibility patch set, a GCC compatibility patch, and musl-specific fixes for the glibc-only `fpu_control.h` header and explicit `select()` declarations. It adapts `mpcchap` to libcue 2.3.0’s `cue_parse_file(FILE *)` API and compiles `libcue` and `libreplaygain` as static libraries.

## Build the tools image

Use Docker or Podman without selecting a special build target:

```sh
podman build -t musepack:rolling .
# or: docker build -t musepack:rolling .
```

The single final `scratch` image contains the executables under `/usr/local/bin` and license notices under `/usr/share/licenses/musepack-static`. It intentionally contains no shell or package manager.

## Copy binaries into another image

The resulting image can be used directly as a source stage, without `docker buildx --target`:

```dockerfile
FROM your-runtime-image
COPY --from=musepack:rolling /usr/local/bin/mpcdec /usr/local/bin/mpcdec
```

Build the Musepack image first and ensure the build engine can resolve the `musepack:rolling` image. Build and destination images must target the same CPU architecture.

To export the binaries to the host with Podman:

```sh
mkdir -p dist
cid="$(podman create musepack:rolling)"
trap 'podman rm -f "$cid" >/dev/null 2>&1 || true' EXIT
podman cp "$cid":/usr/local/bin dist/
podman cp "$cid":/usr/share/licenses/musepack-static dist/licenses
podman rm "$cid"
trap - EXIT
```

With Docker, use the equivalent `docker create`, `docker cp`, and `docker rm` commands.

## Use as a Kubernetes ImageVolume

The same image can be mounted as an ImageVolume; there is no separate `image-volume` build target. Because the image preserves `/usr/local/bin`, mounting it at `/tools` exposes commands at `/tools/usr/local/bin/`:

```yaml
volumes:
  - name: musepack-tools
    image:
      reference: registry.jjgadgets.tech/musepack:latest
      pullPolicy: IfNotPresent
containers:
  - name: worker
    image: your-runtime-image
    command: ["/tools/usr/local/bin/mpcenc"]
    volumeMounts:
      - name: musepack-tools
        mountPath: /tools
        readOnly: true
```

Build and push the single final image:

```sh
podman build -t registry.jjgadgets.tech/musepack:latest .
podman push registry.jjgadgets.tech/musepack:latest
```

## Portability and verification

Libtool receives `-all-static` at the link stage so that the final executables are statically linked; `-static` alone is not sufficient because it only selects static Libtool libraries. The build fails if a generated executable has an ELF interpreter (`PT_INTERP`) or dynamic `DT_NEEDED` dependencies. The tools therefore do not require the target image to contain glibc/musl or Musepack shared libraries. They still require a compatible Linux kernel and the same CPU architecture; they are not Windows/macOS binaries or cross-architecture executables.

The source archives are pinned by SHA-256. The build also performs basic execution smoke tests on the generated tools. All compilation and static-link checks should be run on a machine with access to the upstream source URLs.

The link-order fixes are split into two patches for `mpc2sv8`/`mpcdec` and a narrowly scoped `mpcenc` patch. This avoids the context-sensitive combined `mpcenc` hunk in the original Arch patch while preserving the intended library order (`-lm` after the static archives). The musl compatibility patch follows the established Buildroot fixes: include `<fpu_control.h>` only when using glibc, and include `<sys/select.h>` for the `fd_set`/`select()` declarations. The libcue API compatibility patch opens the CUE sheet before calling libcue 2.3.0 and closes the stream after parsing.
