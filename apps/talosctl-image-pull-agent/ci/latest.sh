#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/siderolabs/talos/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
