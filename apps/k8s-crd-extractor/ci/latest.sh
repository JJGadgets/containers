#!/usr/bin/env bash
version="$(date +%Y.%m.%d)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
