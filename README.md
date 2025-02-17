<!---
NOTE: AUTO-GENERATED FILE
to edit this file, instead edit its template at: ./github/scripts/templates/README.md.j2
-->
<div align="center">


## Containers

_A heavily opinionated collection of container images_

</div>

<div align="center">

![GitHub Repo stars](https://img.shields.io/github/stars/JJGadgets/containers?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/JJGadgets/containers?style=for-the-badge)
![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/JJGadgets/containers/release-scheduled.yaml?style=for-the-badge&label=Scheduled%20Release)

</div>

<div align="center">

[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/JJGadgets/containers/badge)](https://securityscorecards.dev/viewer/?uri=github.com/JJGadgets/containers)

</div>

Welcome to @JJGadgets' container images, if looking for a container start by [browsing the Packages tab in GitHub for this repo](https://github.com/JJGadgets?tab=packages&repo_name=containers).

## Mission statement

The containers found in this repo have similar baseline goals to the ones found in [onedr0p's containers repo](https://github.com/onedr0p/containers).

However, the containers found in this repo are more opinionated for my (@JJGadgets) use.

For example, using distroless base images, or adding on packages/plugins that fit my use case (e.g. Caddy plugins, installing smbclient packages on NextCloud, changing out the web servers on frontend containers from Nginx to Caddy), etc.

I (@JJGadgets) make no guarantees that the containers found here will work for everyone else, **as long as it works for me and fulfils my uses**, I consider it "stable and tested". If you understand that, feel free to use them too!

## Tag immutability

The containers built here do not use immutable tags, as least not in the more common way you have seen from [linuxserver.io](https://fleet.linuxserver.io/) or [Bitnami](https://bitnami.com/stacks/containers).

We do take a similar approach but instead of appending a `-ls69` or `-r420` prefix to the tag we instead insist on pinning to the sha256 digest of the image, while this is not as pretty it is just as functional in making the images immutable.

| Container                                                                 | Immutable  |
|---------------------------------------------------------------------------|------------|
| `registry.jjgadgets.tech/jjgadgets/gotosocial:rolling`                    | ❌         |
| `registry.jjgadgets.tech/jjgadgets/gotosocial:0.12.2.1507`                | ❌         |
| `registry.jjgadgets.tech/jjgadgets/gotosocial:rolling@sha256:8053...`     | ✅         |
| `registry.jjgadgets.tech/jjgadgets/gotosocial:0.12.2.1507@sha256:8053...` | ✅         |

_If pinning an image to the sha256 digest, tools like [Renovate](https://github.com/renovatebot/renovate) support updating the container on a digest or application version change._

## Passing arguments to a application

Some applications do not support defining configuration via environment variables and instead only allow certain config to be set in the command line arguments for the app. To circumvent this, for applications that have an `entrypoint.sh` read below.

1. First read the Kubernetes docs on [defining command and arguments for a Container](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/).
2. Look up the documentation for the application and find a argument you would like to set.
3. Set the argument in the `args` section, be sure to include `entrypoint.sh` as the first arg and any application specific arguments thereafter.

    ```yaml
    args:
      - /entrypoint.sh
      - --port
      - "8080"
    ```

## Configuration volume

For applications that need to have persistent configuration data the config volume is hardcoded to `/config` inside the container. This is not able to be changed in most cases.

## Available Images

Each Image will be built with a `rolling` tag, along with tags specific to it's version. Available Images Below

Container | Channel | Image | Latest Tags
--- | --- | --- | ---
[bird](https://github.com/JJGadgets//containers/pkgs/container/bird) | stable | registry.jjgadgets.tech/jjgadgets/bird |![2.15.1-r0](https://img.shields.io/badge/2.15.1--r0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[davical](https://github.com/JJGadgets//containers/pkgs/container/davical) | stable | registry.jjgadgets.tech/jjgadgets/davical |![1.1.12-2](https://img.shields.io/badge/1.1.12--2-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[elk](https://github.com/JJGadgets//containers/pkgs/container/elk) | stable | registry.jjgadgets.tech/jjgadgets/elk |![0.16.0](https://img.shields.io/badge/0.16.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[fava]() | stable | registry.jjgadgets.tech/jjgadgets/fava |
[findmydeviceserver](https://github.com/JJGadgets//containers/pkgs/container/findmydeviceserver) | stable | registry.jjgadgets.tech/jjgadgets/findmydeviceserver |![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square) ![v0.7.0](https://img.shields.io/badge/v0.7.0-blue?style=flat-square)
[findmydeviceserver-master](https://github.com/JJGadgets//containers/pkgs/container/findmydeviceserver-master) | master | registry.jjgadgets.tech/jjgadgets/findmydeviceserver-master |![master](https://img.shields.io/badge/master-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[fortidynasync](https://github.com/JJGadgets//containers/pkgs/container/fortidynasync) | stable | registry.jjgadgets.tech/jjgadgets/fortidynasync |![0.0.1](https://img.shields.io/badge/0.0.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[goatcounter](https://github.com/JJGadgets//containers/pkgs/container/goatcounter) | stable | registry.jjgadgets.tech/jjgadgets/goatcounter |![2.5.0](https://img.shields.io/badge/2.5.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[gotosocial]() | stable | registry.jjgadgets.tech/jjgadgets/gotosocial |
[gotosocial-rc]() | rc | registry.jjgadgets.tech/jjgadgets/gotosocial-rc |
[jjgadgets-error-page-ingress-nginx](https://github.com/JJGadgets//containers/pkgs/container/jjgadgets-error-page-ingress-nginx) | stable | registry.jjgadgets.tech/jjgadgets/jjgadgets-error-page-ingress-nginx |![1.0.0-caddy-2.7.5](https://img.shields.io/badge/1.0.0--caddy--2.7.5-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[joplin](https://github.com/JJGadgets//containers/pkgs/container/joplin) | stable | registry.jjgadgets.tech/jjgadgets/joplin |![2.13.5-beta](https://img.shields.io/badge/2.13.5--beta-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[k8s-crd-extractor]() | stable | registry.jjgadgets.tech/jjgadgets/k8s-crd-extractor |
[mlc-llm](https://github.com/JJGadgets//containers/pkgs/container/mlc-llm) | stable | registry.jjgadgets.tech/jjgadgets/mlc-llm |![0.19.0](https://img.shields.io/badge/0.19.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[mlc-llm-cuda](https://github.com/JJGadgets//containers/pkgs/container/mlc-llm-cuda) | cuda | registry.jjgadgets.tech/jjgadgets/mlc-llm-cuda |![0.19.0](https://img.shields.io/badge/0.19.0-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[mlc-llm-cuda-nightly](https://github.com/JJGadgets//containers/pkgs/container/mlc-llm-cuda-nightly) | cuda-nightly | registry.jjgadgets.tech/jjgadgets/mlc-llm-cuda-nightly |![2025.02.17](https://img.shields.io/badge/2025.02.17-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[mlc-llm-nightly](https://github.com/JJGadgets//containers/pkgs/container/mlc-llm-nightly) | nightly | registry.jjgadgets.tech/jjgadgets/mlc-llm-nightly |![2025.02.17](https://img.shields.io/badge/2025.02.17-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[phanpy](https://github.com/JJGadgets//containers/pkgs/container/phanpy) | stable | registry.jjgadgets.tech/jjgadgets/phanpy |![2025.01.26.24f03f5](https://img.shields.io/badge/2025.01.26.24f03f5-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[radicale](https://github.com/JJGadgets//containers/pkgs/container/radicale) | stable | registry.jjgadgets.tech/jjgadgets/radicale |![3.4.1](https://img.shields.io/badge/3.4.1-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[radicale-beta](https://github.com/JJGadgets//containers/pkgs/container/radicale-beta) | beta | registry.jjgadgets.tech/jjgadgets/radicale-beta |![3.2.2](https://img.shields.io/badge/3.2.2-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[rclone]() | stable | registry.jjgadgets.tech/jjgadgets/rclone |
[redbot-distroless](https://github.com/JJGadgets//containers/pkgs/container/redbot-distroless) | stable | registry.jjgadgets.tech/jjgadgets/redbot-distroless |![3.5.16](https://img.shields.io/badge/3.5.16-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)
[samba-debian](https://github.com/JJGadgets//containers/pkgs/container/samba-debian) | stable | registry.jjgadgets.tech/jjgadgets/samba-debian |![4.17.12](https://img.shields.io/badge/4.17.12-blue?style=flat-square) ![rolling](https://img.shields.io/badge/rolling-blue?style=flat-square)


### Automated tags

Here's an example of how tags are created in the GitHub workflows, be careful with `metadata.json` as it does affect the outcome of how the tags will be created when the application is built.

| Application     | Channel   | Stable  | Base    | Generated Tag                    |
|-----------------|-----------|---------|---------|----------------------------------|
| `ubuntu`        | `focal`   | `true`  | `true`  | `ubuntu:focal-rolling`           |
| `ubuntu`        | `focal`   | `true`  | `true`  | `ubuntu:focal-19880312`          |
| `alpine`        | `3.16`    | `true`  | `true`  | `alpine:rolling`                 |
| `alpine`        | `3.16`    | `true`  | `true`  | `alpine:3.16.0`                  |
| `gotosocial`    | `develop` | `false` | `false` | `gotosocial-develop:0.12.2.1538` |
| `gotosocial`    | `develop` | `false` | `false` | `gotosocial-develop:rolling`     |
| `gotosocial`    | `main`    | `true`  | `false` | `gotosocial:0.12.2.1507`         |
| `gotosocial`    | `main`    | `true`  | `false` | `gotosocial:rolling`             |

## Deprecations

Containers here can be **deprecated** at any point, this could be for any reason described below.

1. The upstream application is **no longer actively developed**
2. The upstream application has an **official upstream container** that follows closely to the mission statement described here
3. The upstream application has been **replaced with a better alternative**
4. The **maintenance burden** of keeping the container here **is too bothersome**

**Note**: Deprecated containers in this repo may be removed at any time. Hopefully procrastination will keep the deprecated containers long enough.

## Credits

This repo's main pipeline code (found in `.github`) was taken from [onedr0p's containers repo](https://github.com/onedr0p/containers). Full attributions can be found in the `.github/CREDITS.md`.