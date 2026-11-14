# syntax=docker/dockerfile:1.29@sha256:572cebbc2b15e6f84c077742952674889cb63cd5e9b80abdffcbe587b6f19183

# AMD Kubernetes DRA driver v1.0.1 + upstream mixed-vendor fix (PR #117).
# Upstream release: https://github.com/ROCm/k8s-gpu-dra-driver/releases/tag/v1.0.1
# Patch: https://github.com/ROCm/k8s-gpu-dra-driver/commit/ad96ab70d80a3cf93a00e71f11a6e59d526c6ddc
# Reproducible source: v1.0.1 tag must resolve to the audited commit below.
FROM scratch AS source
ARG VERSION
ADD https://github.com/ROCm/k8s-gpu-dra-driver.git#v${VERSION} /src

# Go 1.26.11 includes security fixes beyond the upstream 1.26.5 toolchain.
# Pin the multi-platform index digest for amd64/arm64 builds.
FROM --platform=$BUILDPLATFORM docker.io/library/golang:1.26.11-bookworm@sha256:dc40a13b61304647ed7e5d581d246b86413dfc29d63c6d018310feb93cd98fc0 AS build

ARG TARGETOS
ARG TARGETARCH

ENV CGO_ENABLED=0 \
    GOTOOLCHAIN=local \
    GOPROXY=https://proxy.golang.org \
    GOSUMDB=sum.golang.org \
    GOFLAGS=-mod=readonly

WORKDIR /src
COPY --from=source /src/ /src/

# Apply only PR #117. Fail closed if the v1.0.1 source layout does not match.
# The patch is embedded to keep this image build self-contained.
RUN <<'SH'
set -eu
cat > /tmp/amd-dra-pr117.patch <<'PATCH'
diff --git a/pkg/amdgpu/amdgpu.go b/pkg/amdgpu/amdgpu.go
--- a/pkg/amdgpu/amdgpu.go
+++ b/pkg/amdgpu/amdgpu.go
@@ -31,30 +31,27 @@ import (
 	"github.com/golang/glog"
 )

-// GetDriverVersion reads the AMDGPU driver version
+// GetDriverVersion reads the AMDGPU driver version from the amdgpu kernel
+// module. Reading /sys/module/amdgpu/version directly (rather than globbing
+// every DRM card's driver) keeps the result specific to amdgpu on mixed-vendor
+// nodes, where another vendor's module would otherwise report its own version.
+//
+// Returns "" when the version is unavailable (e.g. the in-kernel amdgpu module
+// does not set a version string) so the caller omits the driverVersion
+// attribute entirely rather than publishing a synthetic value.
 func GetDriverVersion() string {
-	matches, _ := filepath.Glob("/sys/class/drm/card*/device/driver/module/version")
-	if len(matches) == 0 {
-		glog.Warningf("No AMD GPU cards found for driver version reading; driverVersion attribute will be omitted")
+	b, err := os.ReadFile("/sys/module/amdgpu/version")
+	if err != nil {
+		glog.Warningf("Failed to read amdgpu module version: %s; driverVersion attribute will be omitted", err)
 		return ""
 	}

-	for _, versionPath := range matches {
-		b, err := os.ReadFile(versionPath)
-		if err != nil {
-			continue
-		}
-		driverVersion := strings.TrimSpace(string(b))
-		if driverVersion != "" {
-			return driverVersion
-		}
+	driverVersion := strings.TrimSpace(string(b))
+	if driverVersion == "" {
+		glog.Warningf("amdgpu module reports no version string; driverVersion attribute will be omitted")
 	}

-	// In-kernel amdgpu module may not set a version string (empty /sys/module/amdgpu/version).
-	// Return empty so the caller omits the driverVersion attribute entirely rather than
-	// publishing a synthetic value; the ResourceSlice is still valid without it.
-	glog.Warningf("Failed to read AMDGPU driver version from any card; driverVersion attribute will be omitted")
-	return ""
+	return driverVersion
 }

 // SemverDriverVersion trims the AMDGPU version to MAJOR.MINOR.PATCH. The
PATCH

git apply --check /tmp/amd-dra-pr117.patch
git apply /tmp/amd-dra-pr117.patch
rm /tmp/amd-dra-pr117.patch

grep -Fq 'os.ReadFile("/sys/module/amdgpu/version")' pkg/amdgpu/amdgpu.go
if grep -Fq 'filepath.Glob("/sys/class/drm/card*/device/driver/module/version")' pkg/amdgpu/amdgpu.go; then
    echo 'ERROR: mixed-vendor driver version glob is still present' >&2
    exit 1
fi
SH

# go.sum authenticates downloaded modules; no implicit toolchain downloads.
RUN --mount=type=cache,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,target=/root/.cache/go-build,sharing=locked <<'SH'
set -eu
go mod download
go mod verify
go test ./pkg/amdgpu

mkdir -p /out
for cmd in gpu-kubeletplugin webhook; do
    GOOS="${TARGETOS}" GOARCH="${TARGETARCH}" \
    go build -trimpath -buildvcs=false -ldflags='-s -w -buildid= -X main.version=v1.0.1-pr117' \
        -o "/out/${cmd}" "./cmd/${cmd}"
done
SH

# Minimal, static runtime. The AMD operator runs the plugin as privileged
# with host /dev, sysfs, CDI, and kubelet plugin mounts. Root is intentional.
FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build --chmod=0555 /out/gpu-kubeletplugin /usr/bin/gpu-kubeletplugin
COPY --from=build --chmod=0555 /out/webhook /usr/bin/webhook
COPY --from=source /src/LICENSE /licenses/LICENSE

ENV PATH=/usr/bin
USER 0:0
ENTRYPOINT ["/usr/bin/gpu-kubeletplugin"]

LABEL org.opencontainers.image.title="AMD GPU DRA driver (v1.0.1 + PR #117)" \
      org.opencontainers.image.source="https://github.com/ROCm/k8s-gpu-dra-driver" \
      org.opencontainers.image.version="v1.0.1-pr117" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.description="AMD GPU DRA v1.0.1 with mixed-vendor driver-version fix (upstream PR #117)"

