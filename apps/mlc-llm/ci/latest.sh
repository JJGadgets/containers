#!/usr/bin/env bash
channel=$1

version="rolling"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
