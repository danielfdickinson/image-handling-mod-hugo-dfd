#!/bin/bash

set -e
set -o pipefail

SITEROOT="$(pwd)"

if [ -d exampleSite ]; then
	SITESRC=exampleSite/
fi

if echo y | npx html-validate -c .htmlvalidate.json \
	"${SITEROOT}"/${SITESRC}public/** 2>&1 | tee html-validate.log; then
	echo "ok"
	exit 0
else
	echo "not ok"
	exit 1
fi
