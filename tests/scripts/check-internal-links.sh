#!/bin/bash

set -e
set -o pipefail

if [ -z "$SKIP_CHECK_PATTERNS" ]; then
	SKIP_CHECK_PATTERNS="https://www.facebook.com/sharer.php \
https://www.linkedin.com/shareArticle	\
https://linkedin.com/shareArticle \
https://twitter.com/share \
https://www.pexels.com \
https://pixabay.com \
http://doi.org/ \
https://doi.org/ \
https://www.nature.com/ \
https://arxiv.org/ \
https://www.facebook.com/ \
https://facebook.com/ \
https://business.facebook.com \
example.com \
example.net"
fi

CROOT="${1:-https://www.example.com/}"
SITEROOT="$(pwd)"

if [ -d exampleSite ]; then
	SITESRC="$(pwd)"/exampleSite
else
	SITESRC=${SITEROOT}
fi

if grep -q baseURL "${SITESRC}"/config.yaml; then
	CROOT="$(grep baseURL "${SITESRC}"/config.yaml | \
	sed -e 's/^[^:]*: *\(.*\)$/\1/')"
fi

echo "Using ${CROOT} as canonicalRoot"

SKIPS=""
# shellcheck disable=SC2089
for skip in ${SKIP_CHECK_PATTERNS}; do \
	SKIPS="${SKIPS}${SKIPS:+ }--skip \"${skip}\""
done

URLBASE="${SITESRC}"/public/index.html

# shellcheck disable=SC2090,SC2086
if echo y | npx hyperlink "$URLBASE" --canonicalRoot "${CROOT}" \
	--internal \
	${SKIPS} \
	--todo "301 http" \
	--todo "fragment-redirect" \
	-c 10 \
	-r -p "$URLBASE" | tee check-links.log | ( echo y ; cat - ) | \
	npx tap-spot; then
	echo "ok"
	exit 0
else
	echo "not ok"
	exit 1
fi
