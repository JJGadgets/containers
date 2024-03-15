#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/cheeaun/phanpy/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null | awk -F'.' 'sub(FS $NF,x)')" # https://unix.stackexchange.com/a/549210
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"