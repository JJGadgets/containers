#!/usr/bin/env bash
version="$(curl -sX GET "https://api.github.com/repos/caddyserver/caddy/releases/latest" | jq --raw-output '.tag_name' 2>/dev/null)"
version="${version#*v}"
version="${version#*release-}"
version="1.0.0-caddy-${version}"
printf "%s" "${version}"
