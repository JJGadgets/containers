#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "beta" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/laurent22/joplin/releases" | jq --raw-output 'map(select(.prerelease)) | first | .tag_name' 2>/dev/null)"
fi

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://hub.docker.com/v2/repositories/joplin/server/tags/?page_size=
1" | jq --raw-output '.results.[0].name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
