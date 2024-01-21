#!/usr/bin/env bash
channel=$1

if [[ "${channel}" == "rc" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/rclone/rclone/releases" | jq --raw-output 'map(select(.prerelease)) | first | .tag_name' 2>/dev/null)"
fi

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/rclone/rclone/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
