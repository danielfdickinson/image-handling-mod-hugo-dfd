# DFD Hugo Image Handling Module

A Hugo module for handling images and image-related functionality for themes (including enabling responsive images).

## Status

![build-and-verify](https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/actions/workflows/build-and-verify.yml/badge.svg)

## GitHub Repository

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd>

## Features

* From Hugo content files
  * via a render-image hook (Markdown content only)
  * via a shortcode (override of default 'figure' shortcode from Hugo core)
* Microformat (e.g. Open Graph/Twitter) support (requires [DFD Hugo Metadata Module](https://github.com/danielfdickinson/metadata-mod-hugo-dfd) or equivalent),
* Thumbnails (e.g. for blog/taxonomy/HTML sitemap/etc listings)
  * Configurable between thumbnail and full width or height image
  * Sitewide defaults that are overridable per-page
* Fallback for non-resource images
* Image conversion (e.g. to webp)
* Allows wrapping a link around the image(s) which points to the base image.
  * (optionally can point to original format image)
* Allows wrapping a link around the image(s) which points to any URL.
* Configurable responsive behaviour (sizes attribute and sizes of images and/or alternate images based on media queries)
* Allow disabling responsive images (e.g. single image/size; useful if all you want is image conversion or just the wrapper functionality).

## Basic Usage of the Module

### Importing the Module

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

### Add the Image

1. Place your image (e.g. ``screenshot.png``) in a [Page Bundle](https://gohugo.io/content-management/page-bundles/)
   * **NB** You can only use subdirectories with leaf bundles. For branch bundles the image must be in the same directory as the ``_index.md``.
2. OR under ``assets`` in your project root (in which case you can use subdirectories under ``assets`` (e.g. ``assets/path/to/screenshot.png``))

**NB** If you don't use a page bundle or ``assets`` (e.g. if you place the image under ``static``, the image can still be used, but cannot be made responsive).

### Add CSS to Style the Images

For example for the demo site we use:

```css
figcaption {
    font-style: italic;
}

/* We don't specify a default height for bare img (no class or id)
 * because doing so is not reversible in more
 * specific elements. This is a major pain point for many projects.
 */

#via-markdown ~ p img {
    height: auto;
    width: auto;
    max-height: 50vh;
    max-width: 100%;
}

#via-markdown ~ p span {
    display: block;
    margin-top: .4em;
}

#via-markdown ~ p span span {
    display: block;
    margin-top: .4em;
}

.responsive-thumbnail {
    display: inline-block;
    margin-right: 1em;
}

.responsive-figure img {
    height: auto;
    width: auto;
    max-height: 50vh;
    max-width: 100%;
}

.responsive-figure figcaption h2 {
    font-size: 1rem;
}

.responsive-figure figcaption p {
    font-size: .875rem;
}

.responsive-figure.fullwidth img {
    height: auto;
    width: 100%;
    max-height: unset;
}

.responsive-figure-originalheight {
    display: block;
    margin: 0;
    overflow: visible;
}

.responsive-figure-originalheight img {
    box-sizing: content-box;
    display: block;
    margin: 0;
    min-height: max-content;
    min-width: max-content;
    overflow: visible;
}

.markdown-image-wrapper > span {
    display: block;
    margin-top: .4em;
}

.markdown-image-wrapper img {
    height: auto;
    width: auto;
    max-height: 50vh;
    max-width: 100%;
}

.responsive-div img {
    height: auto;
    width: auto;
    max-height: 50vh;
    max-width: 100%;
}

.responsive-markdown img {
    height: auto;
    width: auto;
    max-height: 50vh;
    max-width: 100%;
}

#markdown-thumbnail-test ~ p {
    display: inline-block;
    margin-right: 1em;
}

.thumbnail-markdown {
    display: inline-block;
}

.thumbnail-markdown span span {
    display: none;
}

.thumbnail-figure figcaption {
    display: none;
}

.thumbnail-figure {
    display: inline-block;
    margin-right: 1em;
}

.main-test-min [id|="dfd-hugo-image-handling-module"] ~ #examples ~ [id|="result"] + p {
    background-color: black;
    display: block;
    line-height: 1;
    width: 100%;
}

.main-test-min [id|="dfd-hugo-image-handling-module"] ~ #examples ~ [id|="result"] + p img {
    background-color: whitesmoke;
    border: 2px solid black;
    height: auto;
    opacity: .75;
    padding: .4em;
    width: 100%;
}

@media screen and (max-width: 768px) {
    #markdown-thumbnail-test ~ p {
        display: block;
        margin-right: revert;
    }

    .thumbnail-markdown {
        display: revert;
    }

    .thumbnail-markdown span span {
        display: block;
    }

    .thumbnail-figure figcaption {
        display: block;
    }

    .thumbnail-figure {
        display: block;
        margin-right: revert;
    }
}

.metadata-image-wrapper {
    width: 100%;
}

.metadata-image {
    display: block;
    margin-bottom: 1em;
    margin-left: auto;
    margin-right: auto;
}

.featured-image-flex-wrapper {
    display: flex;
    flex-flow: row nowrap;
    justify-content: flex-start;
}

.featured-image-thumbnail-article {
    flex: 0 0 50%;
    width: 50%;
}

.featured-image-thumbnail-wrapper {
    display: block;
    overflow: hidden;
    z-index: 3;
}

.featured-image-thumbnail-link {
    display: block;
}

.featured-image-thumbnail {
    display: block;
    height: auto;
    max-height: 9em;
    max-width: 100%;
    width: auto;
}

.featured-image-header {
    flex: 0 0 50%;
    margin-bottom: 1em;
    overflow: hidden;
    position: relative;
    width: 50%;
    z-index: 0;
}

.featured-image-wrapper {
    display: block;
    overflow: hidden;
    z-index: 3;
}

.featured-image-link {
    display: block;
}

.featured-image {
    display: block;
}

@media screen and (max-width: 768px) {
    .featured-image-flex-wrapper {
        display: flex;
        flex-flow: column wrap;
    }

    .featured-image-thumbnail-article {
        flex: 1 1 100%;
        width: 100%;
    }

    .featured-image-header {
        flex: 1 1 100%;
        width: 100%;
    }

    .featured-image-wrapper {
        margin-top: 1em;
        position: relative;
    }

    .featured-image {
        height: auto;
        margin-bottom: 0;
        width: 100%;
    }
}

@media screen and (min-width: 768px) {
    .featured-image-header {
        height: 70vh;
    }

    .featured-image-wrapper {
        bottom: 0;
        left: 0;
        position: absolute;
        right: 0;
        top: 0;
    }

    .featured-image {
        max-height: 100%;
        max-width: 100%;
        width: auto;
    }

    .featured-image:not([src*=".svg"]) {
        height: fit-content;
    }

    .featured-image[src*=".svg"] {
        height: auto;
    }

    .featured-image-link {
        height: 100%;
        width: 100%;
    }
}
```

### Use Markdown (render-image render hook makes it responsive)

E.g.

```markdown
![Screenshot of a web page with an aqua theme](screenshot.png)
```

### Use Figure Shortcode

E.g.

### Example #1

```markdown
{{< figure class="responsive-figure" title="Figure 1: Differences between markdown figures and figure shortcode" src="screenshot.png" alt="Screenshot of a web page with an aqua theme" caption="For a figure caption can be different than alt text">}}
```

### Example #2

```markdown
{{< figure class="responsive-figure fullwidth" title="Figure 1: Differences between markdown figures and figure shortcode (full width)" src="screenshot.png" alt="Screenshot of a web page with an aqua theme" caption="For a figure caption can be different than alt text">}}
```

See ['wrapped image' partial](#wrapped-image), below, for the full set of parameters you can use with the shortcode.

## Advanced Usage

### Image Handling Partials

#### Wrapped Image

* You have access to the ``helpers/wrapped-image`` partial in your layouts and shortcodes.
* Outputs the HTML to display an image (an \<img> tag) which is responsive by default (but doesn't have to be, optionally wrapped in \<figure>, \<span>, or \<div>, all if which maybe optionally wrapped in a link (\<a href="..."> element).
* Not all combinations of parameters make sense.

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
    "caption" "A <figcaption> if image wrapper is <figure>, <span> if there is no title, or <div> if there is a title (because title will be wrapped in an <h2>"
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
    )
-}}
```

#### Featured Images

* You have access to the ``helpers/featured-images`` partial in your layouts and shortcodes.
* Returns the set of featured images and related parameters for this page
  1. For image(s) specified by page-level parameters (frontmatter) search for images in page bundles or site assets:
     1. imageFeatured
     2. imageCover
     3. imageThumbnail
     4. featured_image
  2. If none found via step #1, look in the current page bundle for:
     1. \*feature*
     2. \*cover*,\*thumbnail*
  3. If not found via step #2, find images by page-level params, searching for images in the static directory.

Featured images each have a URL, alt text (if any), title (if any), secure_url (https, if any), and the image resource (for images from a page bundle or from site assets), width (for processable images only), and height (for processable images only).

```html
{{ partial "helpers/featured-images" . -}}
```

#### Featured Image

* As [Featured Images](#featured-images) but only returns the first featured image found above.

```html
{{ partial "helpers/featured-image" . -}}
```

#### Featured Image Link

* As [Featured Image](#featured-image) but only returns the link (URL) of the featured image.

```html
{{ partial "helpers/featured-image-link" . -}}
```

### Metadata Gathering

See [DFD Hugo Metadata Module](https://github.com/danielfdickinson/metadata-mod-hugo-dfd) for more information.

Metadata types that can be gathered are:

* ``media-images`` A slice if maps (dictionaries) with image information for use in microformats and other metadata; images matched are the same as [Featured Images](#featured-images) above.
* ``media-image`` A map (dictionary) with image information for the first image from ``media-images`` which corresponds to [Featured Image](#featured-image) above.

Gathering image metadata may also create an image for specifically for use with microformats (see [For Microformats](#for-microformats) , below).

### Site or Page Params

#### For All Processable Images

Currently:

* png
* jpeg/jpg
* tif/tiff
* bmp
* gif
* webp (only for Hugo Extended)

| Param | Default | Description |
|-------|---------|-------------|
| imageResponsive | true | Make images responsive (have srcset and sizes) |
| imageConvertTo | _(nil)_ | Convert all images to specified format (must be an a format supported by Hugo; "webp" requires Hugo Extended) |
| imageImageSizes | ["480","720","1080","1280","1600","2048"] | Sizes (widths) of responsive image to generate |
| singleSize | false (when true overrides default imageImagesSizes to "\<image-width>x\<image-height>"]) | Only generate one size of image |

TODO: Add imageConvertMethod as an option for any image: [ Fit \| GrowFit \| Fill \| Resize ].

#### For All Image Shortcodes

| Param | Default | Description |
|-------|---------|-------------|
| imageLoading | _(nil)_ | Default value of the 'loading=' attribute for all images on the page (or site, for site-level) |

#### For Wrapped Images

| Param | Default | Description |
|-------|---------|-------------|
| imageLinkFull | _(nil)_ | Link in which to wrap image if not provided by shortcode or partial (always applies to markdown images) |
| imageAddWrapper | _(nil)_ | Element in which to wrap image if not provided by shortcode or partial (always applies to markdown images) |
| imageAddClass | _(nil)_ | Classes (space separated string) to add to wrapper element or img element if no image wrapper |
| imageAltAsCaption | false | Use alt text as caption when using image wrapper (unless caption specified) |
| imageSizesAttr | 80vw | For responsive images the default "sizes=" attribute |
| imageFullSize | true | generate full sized image |
| imageThumbnails | false | Whether or not to generate thumbnail images |
| imageThumbnailSizes | ["180","360","512"] | Default image sizes (widths) to generate when generating thumbnails |
| imageThumbnailWidth | 512 | Width of 'base' thumbnail |
| imageThumbnailHeight | _(based on thumbnail width and aspect ratio)_ | Height of 'base' thumbnail |
| imageThumbnailSizesAttr | 20vw | For thumbnail images the default "sizes=" attribute |
| imageMinThumbnailViewport | 768px | Minimum viewport for which to generate thumbnails |

#### For Featured Images and Microformats

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

#### For Microformats

| Param | Default | Description |
|-------|---------|-------------|
| microformatWidth | 1200 | Default width for microformat image (e.g. OpenGraph) |
| microformatHeight | 630 | Default height for microformat image (.e.g OpenGraph) |
| microformatConvertMethod | GrowFit | Default method for resize/crop of microformat image [ Fit \| GrowFit \| Fill \| Resize ] |

## Examples

### Test Image #1

#### Source #1

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/blob/main/exampleSite/content/post/testimage1/index.md>

#### CSS #1

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result #1

![Image shows three different styling variations on a screenshot of a website](README-images/testimage1-result-screenshot.png)

### Test Image #2

#### Source #2

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/blob/main/exampleSite/content/post/testimage2/index.md>

#### CSS #2

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result #2

![Image shows four different styling variations on a screenshot of a website](README-images/testimage2-result-screenshot.png)

### Test Image #3

#### Source #3

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/blob/main/exampleSite/content/post/testimage3/index.md>

#### CSS #3

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result #3

![Image shows four different styling variations on a screenshot of a website](README-images/testimage3-result-screenshot.png)

### Test Thumbnails #1

#### Source #4

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/blob/main/exampleSite/content/post/test-thumbnails-1/index.md>

#### CSS #4

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result #4

![Image shows three image thumbnails in a row (with large amounts space between them)](README-images/testthumbnails1-result-screenshot.png)

### Test Thumbnails #2

#### Source #5

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/blob/main/exampleSite/content/post/test-thumbnails-2/index.md>

#### CSS #5

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result #5

![Image shows three image thumbnails in a row (with some space between them)](README-images/testthumbnails2-result-screenshot.png)
