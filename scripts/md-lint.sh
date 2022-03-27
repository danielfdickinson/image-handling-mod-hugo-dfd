#!/bin/bash

set -o pipefail

if npx markdownlint-cli2 README.md "exampleSite/content/*.md" "exampleSite/content/**/*.md" 2>&1 | tee md-lint.log
then
    echo "ok"
else
    echo "not ok"
fi
