#!/usr/bin/env bash
channel=$1

# if [[ "${channel}" == "beta" ]]; then
#     #version="$(curl -sX GET "https://api.github.com/repos/Kozea/Radicale/releases" | jq --raw-output 'map(select(.prerelease)) | first | .tag_name' 2>/dev/null)"
#     version="3.2.2"
# fi

if [[ "${channel}" == "stable" ]]; then
    version="$(curl -sX GET "https://api.github.com/repos/beancount/fava/tags?per_page=1" | jq --raw-output '.[0].name' 2>/dev/null)"
fi
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
