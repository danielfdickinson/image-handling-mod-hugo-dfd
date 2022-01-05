#!/bin/bash

set -o pipefail

if npx html-validate public 2>&1 | tee html-validate.log
then
    echo "ok"
else
    echo "not ok"
fi
