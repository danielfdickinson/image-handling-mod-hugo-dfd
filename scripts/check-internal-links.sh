SKIP_CHECK_PATTERNS="https://www.facebook.com/sharer.php \
https://www.linkedin.com/shareArticle  \
https://linkedin.com/shareArticle \
https://twitter.com/share \
https://www.pexels.com \
https://pixabay.com \
http://doi.org/ \
https://doi.org/ \
https://www.nature.com/ \
https://arxiv.org/ \
example.net"

SKIPS=""; for skip in ${SKIP_CHECK_PATTERNS}; do SKIPS="${SKIPS}${SKIPS:+ }--skip \"${skip}\""; done ; \
export SKIPS

npx hyperlink --root "$(pwd)/public" --canonicalroot https://example.com/ \
    --internal \
    ${SKIPS} \
    --todo "301 http" \
    --todo "fragment-redirect" \
    -r -p public/index.html | tee check-links.log | npx tap-spot
