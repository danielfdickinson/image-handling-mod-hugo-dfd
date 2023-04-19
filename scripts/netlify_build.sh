#!/bin/bash

set -e
set -o pipefail

pip install pre-commit

pre-commit install --install-hooks
pre-commit run --all-files

bash ./tests/scripts/hugo-audit.sh
rm -rf public exampleSite/public

if [ "$CONTEXT" = "production" ]; then
	export HUGO_PARAMS_DEPLOYEDBASEURL="$URL"
else
	export HUGO_PARAMS_DEPLOYEDBASEURL="$DEPLOY_PRIME_URL"
fi

HUGO_RESOURCEDIR="$(pwd)/resources" hugo --gc --minify -b $HUGO_PARAMS_DEPLOYEDBASEURL --source exampleSite --destination "$(pwd)/public" --config "$(pwd)/exampleSite/config.toml"
