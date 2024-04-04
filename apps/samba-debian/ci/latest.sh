#!/usr/bin/env bash
#version="$(curl -sX GET "https://gitlab.nic.cz/labs/bird/-/raw/master/NEWS" 2>/dev/null | awk '/Version/{print $2}' 2>/dev/null | head -n 1 2>/dev/null)"
UPSTREAM=$(curl -sX GET "https://salsa.debian.org/samba-team/samba/-/raw/bookworm/VERSION" 2>/dev/null | grep -v "#")
MAJOR=$(echo "${UPSTREAM}" | awk -F'=' '/SAMBA_VERSION_MAJOR/{print $2}')
MINOR=$(echo "${UPSTREAM}" | awk -F'=' '/SAMBA_VERSION_MINOR/{print $2}')
RELEASE=$(echo "${UPSTREAM}" | awk -F'=' '/SAMBA_VERSION_RELEASE/{print $2}')
version="${MAJOR}.${MINOR}.${RELEASE}"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
