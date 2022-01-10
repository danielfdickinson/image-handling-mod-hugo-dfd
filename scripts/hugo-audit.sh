#/bin/bash

set -o pipefail

[ -z "$HUGO_COMMAND" ] && HUGO_COMMAND="hugo"

if HUGO_MINIFY_TDEWOLFF_HTML_KEEPCOMMENTS=true HUGO_ENABLEMISSINGTRANSLATIONPLACEHOLDERS=true HUGO_RESOURCEDIR=$(pwd)/resources $HUGO_COMMAND --gc --cleanDestinationDir  --destination $(pwd)/public --source $(pwd)/exampleSite
then
    # If hugo build succeeds but possible audit issues are present, check further
    # Check for problem indicators (see https://discourse.gohugo.io/t/audit-your-published-site-for-problems/35184)
    grep -iIrnoE '<\!-- raw HTML omitted -->|ZgotmplZ|hahahugo|\[i18n\]|\(<nil>\)|\(&lt;nil&gt;\)' public/ >hugo-audit.log; RET=$?
    if [ "$RET" != "1" ] && [ "$RET" != "0" ]
    then
        # Make sure we fail if there is is error executing the check command
        echo "not ok"
        exit 1
    fi

    # Check if problem indicators are part of some page's content (e.g. a page describing how
    # to check for Hugo audit issues).
    if [ "$RET" = "0" ]
    then
        grep -iIvE 'grep(.+(-- raw HTML omitted --|ZgotmplZ|hahahugo|\[i18n\]|\(<nil>\)|\(&lt;nil&gt;\))+)' hugo-audit.log; RET2=$?
        if [ "$RET2" != "1" ]
        then
            # Make sure we fail if there is an error executing the false positive elimination command (exit code 2)
            # Also fail if there was a true positive (exit code 0)
            echo "not ok"
            exit 1
        fi
    fi
    echo "ok"
    exit 0
else
    # If Hugo build fails, audit fails
    echo "not ok"
    exit 1
fi