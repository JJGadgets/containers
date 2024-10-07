#!/usr/bin/env bash
set -euo pipefail

channel=$1

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -s https://mlc.ai/wheels | grep -oE '>mlc_llm_cpu-(.*)-cp311-manylinux.*_x86_64.whl' | awk -F'-' '{print $2}' | tail -n 1)"
else if [[ "${channel}" == "nightly" ]]; then
    version="rolling"
else
    echo "No version could be extracted!"
    exit 1
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
