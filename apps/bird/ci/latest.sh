#!/usr/bin/env bash
#version="$(curl -sX GET "https://gitlab.nic.cz/labs/bird/-/raw/master/NEWS" 2>/dev/null | awk '/Version/{print $2}' 2>/dev/null | head -n 1 2>/dev/null)"
version="$(curl -sX GET "https://git.alpinelinux.org/aports/plain/community/bird/APKBUILD" | awk -F'=' '/pkgver/{print $2}')"
version="${version#*v}"
version="${version#*release-}"
version="${version}-r$(curl -sX GET "https://git.alpinelinux.org/aports/plain/community/bird/APKBUILD" | awk -F'=' '/pkgrel/{print $2}')"
printf "%s" "${version}"
