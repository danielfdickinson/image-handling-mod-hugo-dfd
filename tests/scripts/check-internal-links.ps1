cd exampleSite\public
npx.cmd hyperlink index.html --root . --canonicalroot https://image-handling-mod.ci.thecshore.com/ --internal --todo "301 http" --todo "fragment-redirect" -c 10 -r index.html | npx.cmd tap-spot
cd ..\..
