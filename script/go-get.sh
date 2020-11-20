#!/usr/bin/env bash
#
# Intentionally created to install go dependencies that must not occur within the given go project.
#
# Input: expects a go-gettable source to download: e.g. "github.com/psampaz/go-mod-outdated"
set -e

readonly TMP_DIR=$(mktemp -d)
cd "${TMP_DIR}"

go mod init tmp
go get -u "$1"

rm -rf "${TMP_DIR}"
