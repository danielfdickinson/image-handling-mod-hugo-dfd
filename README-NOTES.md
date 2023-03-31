# Notes

## Note 1

Uses [EditorConfig][edconf] for an editor neutral default styling

* Defaults to [using tabs where possible for accessibility
reasons][tabaccess]
* `root = false` so that the user can set their preferred (or required for
accessibility reasons) rendering of the tabs via a `.editorconfig` file in
a higher level directory, or their home directory. Not doing this defeats
the purpose of using tabs vs. spaces.
* `tab_width` is **not** set in this repository so that the user's config
will be used. (See above).

## Note 2

'We' is the 'royal we' (because we don't like saying 'I' a lot and often we
want speak in the first person), and 'I' am
[@danielfdickinson](https://gitlab.com/danielfdickinson).

## Note 3

This repository uses [pre-commit][precommit] to filter out (and potentially
auto-fix) issues with many minor (and some not so minor) 'nits'.

The developer who introduced me to pre-commit has written [a blog post giving
some context and general information on the use
of
'pre-commit'][dnbprecommit],
and the official docs are pretty good too, so perhaps that will suffice.

He prefers a different code spell checker though, but I use [CSpell][cspell].

--------

[cspell]: https://cspell.org
[dnbprecommit]: https://kollitsch.dev/blog/2022/simple-multi-language-pre-commit-hooks/
[edconf]: https://editorconfig.org/
[precommit]: https://pre-commit.com
[tabaccess]: https://www.brycewray.com/posts/2022/06/accessibility-argument-tabs-spaces/
