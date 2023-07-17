#!/bin/bash

set -e
set -o pipefail

# Ensure Go modules with LFS checksum correctly
# Workaround for https://github.com/golang/go/issues/41708
# We don't have LFS on this repo
# git lfs install

bash ./tests/scripts/hugo-audit.sh

rm -rf public exampleSite/public

export HUGO_PARAMS_DEFAULTCANONICAL="$URL"

if [ "$CONTEXT" = "production" ]; then
	export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
	export BASEURL="$URL"
else
	export HUGO_PARAMS_DEPLOYEDBASEURL="$DEPLOY_PRIME_URL"
	export BASEURL="$DEPLOY_PRIME_URL"
fi

if [ "$CONTEXT" = "production" ]; then
	export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
else
	export HUGO_PARAMS_DEPLOYEDBASEURL="$DEPLOY_PRIME_URL"
fi

HUGO_RESOURCEDIR="$(pwd)/resources" hugo --gc --minify -b $HUGO_PARAMS_DEPLOYEDBASEURL --source "$(pwd)"/exampleSite --destination "$(pwd)"/public
