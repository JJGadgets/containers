#!/usr/bin/env bash
version="rolling"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"

