#!/usr/bin/env bash
#version="$(curl -sX GET "https://gitlab.nic.cz/labs/bird/-/raw/master/NEWS" 2>/dev/null | awk '/Version/{print $2}' 2>/dev/null | head -n 1 2>/dev/null)"
version="$(curl -sX GET "https://salsa.debian.org/samba-team/samba/-/raw/bookworm/debian/changelog" 2>/dev/null | head -n 1 | awk -F'[()]' '{print $2}')"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
