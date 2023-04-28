$Env:HUGO_RESOURCEDIR="$PWD\resources"
hugo.exe  serve --buildDrafts --buildFuture --source exampleSite --environment "development" --config config.toml
