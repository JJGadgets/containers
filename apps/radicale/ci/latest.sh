#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "beta" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/Kozea/Radicale/releases" | jq --raw-output 'map(select(.prerelease)) | first | .tag_name' 2>/dev/null)"
fi

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/Kozea/Radicale/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
version="${version#*-version}" # temporary for v3.2.2-version
printf "%s" "${version}"
