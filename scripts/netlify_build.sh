#!/bin/bash

set -e
set -o pipefail

if [ "$CONTEXT" = "production" ]; then
	export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
else
	export HUGO_PARAMS_DEPLOYEDBASEURL="$DEPLOY_PRIME_URL"
fi

HUGO_RESOURCEDIR="$(pwd)/resources" hugo --gc --minify -b $HUGO_PARAMS_DEPLOYEDBASEURL --source exampleSite --destination "$(pwd)/public" --config config.toml
