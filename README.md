# DFD Hugo image handling module

A Hugo module for handling images and image-related functionality for themes (including enabling responsive images).

## Community maintained

This module is has been un-archived to allow community contributions. The original author (@danielfdickinson)
will be (mostly) 'hands-off' due to time constraints.

## Status

[![pre-commit.ci
status](https://results.pre-commit.ci/badge/github/danielfdickinson/image-handling-mod-hugo-dfd/main.svg)](https://results.pre-commit.ci/latest/github/danielfdickinson/image-handling-mod-hugo-dfd/main)

## GitHub repository

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd>

## Site with examples

<https://www.image-handling-mod.wtg-demos.ca>

## Features

* From Hugo content files
  * via a render-image hook _[Note 1](#note-1)_
  * via a shortcode _[Note 2](#note-2)_
* Thumbnails _[Note 3](#note-3)_
  * Configurable between thumbnail and full width or height image
  * Sitewide defaults that are overridable per-page
* Fallback for non-resource images
* Image conversion _[Note 4](#note-4)_
* Allows wrapping a link around the image(s) which points to the base image.
  * optionally can point to original format image
* Allows wrapping a link around the image(s) which points to any URL.
* Configurable responsive behaviour _[Note 5](#note-5)_
* Allow disabling responsive images _[Note 6](#note-6)_
* Supports embedded base64 encoded images.
* Supports image and/or text overlays

## Basic usage of the module

### Prerequisites

1. [Hugo](https://gohugo.io) version 0.96.0 _extended_ version of Hugo, or higher, installed
2. You must have in directory containing a hugo site (e.g. such as created by `hugo new site <directory>`).
3. You must have a recent version of Go installed (see section [Prerequisite in 'Use Hugo Modules' in the Hugo documentation](https://gohugo.io/hugo-modules/use-modules/#prerequisite)).
4. The site must be initialized as a Hugo module (see ['Initialize a New Module' in the Hugo documentation](https://gohugo.io/hugo-modules/use-modules/#initialize-a-new-module), or the output of `hugo mod init`).
5. Before the site will build correctly, [you will also need a theme installed](https://gohugo.io/getting-started/quick-start/#step-3-add-a-theme).

### Importing the module

1. The first step to making use of this module is to add it to your site or theme. In your configuration file:

   ``config.toml``

   ```toml
   [module]
   [[module.imports]]
   path = "github.com/danielfdickinson/image-handling-mod-hugo-dfd"
   ```

   OR
   ``config.yaml``

   ```yaml
   module:
     imports:
       - path: github.com/danielfdickinson/image-handling-mod-hugo-dfd
   ```

2. Execute

   ```bash
   hugo mod get github.com/danielfdickinson/image-handling-mod-hugo-dfd
   hugo mod tidy
   ```

### Add the image

1. Place your image in a [page bundle](https://gohugo.io/content-management/page-bundles/) (e.g. `screenshot.png`) _[Note 7](#note-7)_
2. OR under `assets` in your project root _[Note 8](#note-8)_

If you don't use a page bundle or ``assets``, the image can still be used, but cannot be made responsive _[Note 9](#note-9)_

### Add CSS to style the images

[For the demo we use a small custom CSS file](README-assets/sample.css)

### Use markdown (render-image render hook makes it responsive)

### Example #1

```markdown
![Screenshot of a web page with an aqua theme](screenshot.png)
```

### Use figure shortcode

### Example #2

```markdown
{{</* figure class="responsive-figure" title="Figure 1: Differences between markdown figures and figure shortcode" src="screenshot.png" alt="Screenshot of a web page with an aqua theme" caption="For a figure caption can be different than alt text" */>}}
```

### Example #3

```markdown
{{</* figure class="responsive-figure fullwidth" title="Figure 1: Differences between markdown figures and figure shortcode (full width)" src="screenshot.png" alt="Screenshot of a web page with an aqua theme" caption="For a figure caption can be different than alt text" */>}}
```

See ['wrapped image' partial](#wrapped-image), below, for the full set of parameters you can use with the shortcode.

**NOTE**: The default for the `figure` shortcode is to `ignoreStaticImages`. If you want
to changes that, add a parameter `ignoreStaticImages="false"`. For example:

```markdown
{{</* figure class="static-figure" title="Figure 1: Differences between markdown figures and figure shortcode" src="/images/screenshot.png" alt="Screenshot of a web page with an aqua theme" caption="For a figure caption can be different than alt text" ignoreStaticImages="false" */>}}
```

Static images cannot be made responsive _[Note 9](#note-9)_

## Advanced usage

### base64 encoded images

The `src` parameter can be provided as a base64-encoded image instead of a filename or URI. For example:

```markdown
![Portion of a class diagram](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA…)
```

or more usefully:

```markdown
![Portion of a class diagram][reference-to-image]

Other markdown / text.

[reference-to-image]:data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA…
```

### Image handling partials

#### Wrapped image

* You have access to the ``helpers/wrapped-image`` partial in your layouts and shortcodes.
* Outputs the HTML to display an image (an \<img> tag) which is responsive by default _[Note 10](#note-10)_.
* Not all combinations of parameters make sense.
* When using 'imageFeatured' and/or thumbnails, you might find _noVisibleCaption_ extremely helpful if you use `imageAltAsCaption` as your site default.
* `imageOverlay` and `textOverlay` are different for the `figure` shortcode (see below)

```html
{{ partial "helpers/wrapped-image" (
    dict "width" 1920px
    "height" 1080px
    "thumbnailWidth" "90px"
    "thumbnailHeight" ""
    "alt" "Screenreader text"
    "altRendered" "alt text is HTML, not Markdown or plain (default false)"
    "title" "Title (screenreaders and often tooltips)"
    "image" "Image source (usually relative to page bundle or assets) or srcset (from another partial, below)"
    "page" .Page (Hugo page context; it is unlikely  that you will want this to be other than .Page)
    "class" "Classes (space separated string) to add to the wrapper element, or the img element if there is no image_wrapper"
    "link" "A link in which to wrap the image"
    "linkclass" "Classes (space separated string) to add to a wrapping link (only if 'link' specified)"
    "target" "For link: E.g. ('_blank')"
    "rel" "For link: E.g. ('nofollow')"
    "imageWrapper" "element in which to wrap <img> element"
    "imageClass" "when there is a wrapper, the class to apply to the <img> element"
    "caption" "A <figcaption> if image wrapper is <figure>, <span> if there is no title, or <div> if there is a title (because title will be wrapped in an <h2>)"
    "captionRendered" "caption is HTML, not Markdown or plain (default false)"
    "attr" "More caption text (but can be wrapped by a hyperlink via attrLink), only for a '<figure>'"
    "attrLink" "A hyperlink wrapped around attr, only if 'attr' above"
    "noImageWrapper" (If true you get a bare <img> element; default for render-image render hook)
    "imageSizes" "A slice of widths to use for the srcset"
    "thumbnailSizes" "A slice of width to use for thumbnail srcset"
    "singleSize" "If true, ignore srcset and *sizes; non-responsive img"
    "convertTo" "image format to which to convert (for this call only)"
    "thumbnails" "If true generate thumbnails; if fullsize is also true use a 'picture' element to pick the set of images (thumbnails or full size, based on screen size)
    "fullSize" "If true generate full size images; see thumbnails"
    "sizesAttr" "Overrides img (or source) 'sizes=' attribute"
    "thumbnailSizesAttr" "As with sizesAttr but for thumbnails"
    "minThumbnailViewport" "Minimum size of the viewport that is require to display thumbnails instead of full images"
    "loading" "If set, is the 'loading=' attribute for the 'img'"
    "noVisibleCaption" "If true then when there is a title and/or caption with an imageWrapper do not display the title and/or caption (attributes only)"
    "imageConvertMethod" "Set method for resize/crop of image, from [ Fit \| GrowFit \| Fill \| Resize ]"
    "imageOverlay" "Dict with src, x, and y for image, and x, y position to overlay 'src' on the main image"
    "textOverlay" "Slice of maps (dict) with text, opts (which is a dict, see [Hugo docs](https://gohugo.io/functions/images/#text)) which specifies text to overlay over an image and the options (color, size, etc)"
    )
-}}
```

##### Image and Text overlays for shortcodes

For shortcodes you need to add the definition of the map (for `imageOverlay`) or
list of maps (for `textOverlay`) as a parameter in your frontmatter, and use the
shortcode parameters `imageOverlayParam` and/or `textOverlayParam` to point to the
page frontmatter param.

For example (without the `/*` or `*/`):

``` html
{{</* figure alt="Light blue gradient with the work 'Test' in a large yellow font (if Hugo version >= 0.90.0)" src="/light-blue-gradient-social-card.png" textOverlayParam="figureOverlayText" */ class="responsive-figure" */>}}
```

#### Featured images

* You have access to the ``helpers/featured-images`` partial in your layouts and shortcodes.
* Returns the set of featured images and related parameters for this page
  1. For image(s) specified by page-level parameters (frontmatter) search for images in page bundles or site assets:
     1. imageFeatured
     2. imageCover
     3. imageThumbnail
     4. featured_image
     5. images
  2. If none found via step #1, look in the current page bundle for:
     1. \*feature*
     2. \*cover*,\*thumbnail*
  3. If not found via step #2, find images by page-level params, searching for images in the static directory.

Featured images each have a url and may have

* alt text
* title
* secure_url
* the image resource (for images from a page bundle or from site assets)
* width (for processable images only)
* height (for processable images only).

```html
{{ partial "helpers/featured-images" . -}}
```

#### Featured image

* As [featured images](#featured-images) but only returns the first featured image found above.

```html
{{ partial "helpers/featured-image" . -}}
```

#### Featured image link

* As [featured image](#featured-image) but only returns the link (URL) of the featured image.

```html
{{ partial "helpers/featured-image-link" . -}}
```

### `.Site` or `.Page` params

#### For all processable images

Currently:

* png
* jpeg/jpg
* tif/tiff
* bmp
* gif
* webp (only for Hugo extended)

| Param | Default | Description |
|-------|---------|-------------|
| imageResponsive | true | Make images responsive (have srcset and sizes) |
| imageConvertTo | _(nil)_ | Convert all images to specified format (must be an a format supported by Hugo; "webp" requires Hugo Extended) |
| imageImageSizes | ["480", "720", "1080", "1280", "1600", "2048"] | Sizes (widths) of responsive image to generate |
| singleSize | false (when true overrides default imageImagesSizes to "\<image-width>x\<image-height>"]) | Only generate one size of image |
| imageConvertMethod | Resize | Set method for resize/crop of image, from [ Fit \| GrowFit \| Fill \| Resize ] |

#### For all image shortcodes

| Param | Default | Description |
|-------|---------|-------------|
| imageLoading | _(nil)_ | Default value of the 'loading=' attribute for all images on the page (or site, for site-level) |

#### For wrapped images

| Param | Default | Description |
|-------|---------|-------------|
| imageLinkFull | _(nil)_ | Link in which to wrap image if not provided by shortcode or partial (always applies to markdown images) _[Note 12](#note-11)_ |
| imageAddWrapper | _(nil)_ | Element in which to wrap image if not provided by shortcode or partial (always applies to markdown images) |
| imageAddClass | _(nil)_ | Classes (space separated string) to add to wrapper element or img element if no image wrapper |
| imageAltAsCaption | false | Use alt text as caption when using image wrapper (unless caption specified) |
| imageSizesAttr | 80vw | For responsive images the default "sizes=" attribute |
| imageFullSize | true | generate full sized image |
| imageThumbnails | false | Whether or not to generate thumbnail images |
| imageThumbnailSizes | ["180", "360", "512"] | Default image sizes (widths) to generate when generating thumbnails |
| imageThumbnailWidth | 512 | Width of 'base' thumbnail |
| imageThumbnailHeight | _(based on thumbnail width and aspect ratio)_ | Height of 'base' thumbnail |
| imageThumbnailSizesAttr | 20vw | For thumbnail images the default "sizes=" attribute |
| imageMinThumbnailViewport | 768px | Minimum viewport for which to generate thumbnails |

#### For featured images and microformats

'alt' text from one of:

* imageFeaturedAlt
* imageCoverAlt
* imageThumbnailAlt
* featuredImageAlt
* featuredAlt

'title' from one of:

* imageFeaturedTitle
* imageCoverTitle
* imageThumbnailTitle
* featuredImageTitle
* featuredTitle

#### For Markdown images

| Param | Default | Description |
|-------|---------|-------------|
| imageMarkdownAddWrapper | _false_ | If true add a wrapper (e.g. figure or div) around Markdown images (either `imageMarkdownClass` or `imageAddClass`) |
| imageMarkdownClass | _(none)_ | Class to add to Markdown images |
| imageMarkdownLinkClass | _(none)_ | Class to add to links wrapped around Markdown images |
| imageMarkdownOverlayImage | _(none)_ | Map with src, x, and y for image, and x, y position to overlay 'src' on the main image |
| imageMarkdownOverlayText | _(none)_ | Slice of maps with text, opts (which is a map, see [Hugo docs](https://gohugo.io/functions/images/#text)) which specifies text to overlay over an image and the options (color, size, etc). |

## Examples

TBD (once test/demo system rebuilt to separate the images/exampleSite from the module (to avoid unnecessary bandwidth use))

## Endnotes

### Note 1

Markdown content only

### Note 2

Override of default 'figure' shortcode from Hugo core

### Note 3

E.g. for blog/taxonomy/HTML sitemap/etc listings

### Note 4

E.g. to webp

### Note 5

Sizes attribute and sizes of images and/or alternate images based on media queries

### Note 6

E.g. single image/size; useful if all you want is image conversion or just the wrapper functionality

### Note 7

**NB** You can only use subdirectories with leaf bundles. For branch bundles the image must be in the same directory as the `_index.md`

### Note 8

This allows using subdirectories under `assets` (e.g. `assets/path/to/screenshot.png` which would render to `/path/to/screenshot.png`).

### Note 9

E.g. if you place the image under ``static``

### Note 10

But doesn't have to be, and can be optionally wrapped in \<figure>, \<span>, or \<div>.

### Note 11

When using Markdown, if you add links to the full image _and_ wrap the image in a (Markdown) link, the wrapping link will be ignored. Fixing that requires using a `link-render-hook` such as provided by [DFDs Hugo link handling module](https://github.com/danielfdickinson/link-handling-mod-hugo-dfd)

-------

## Colophon

* [Copyright and licensing](LICENSE)
* [Inspirations, information, and source material](ACKNOWLEDGEMENTS.md)
* [Notes](README-NOTES.md)
