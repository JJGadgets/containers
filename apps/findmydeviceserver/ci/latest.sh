#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "master" ]]; then
    version="master"
fi

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://gitlab.com/api/v4/projects/Nulide%2Ffindmydeviceserver/releases" | jq -r '.[0].tag_name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
