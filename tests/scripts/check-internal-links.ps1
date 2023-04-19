cd exampleSite\public
npx.cmd hyperlink index.html --root . --canonicalroot https://image-handling-mod-ci.demo.wildtechgarden.com/ --internal --todo "301 http" --todo "fragment-redirect" -c 10 -r index.html | npx.cmd tap-spot
cd ..\..
