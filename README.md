# DFD Hugo Image Handling Module

A Hugo module for handling images and image-related functionality for themes

## Status

![build-and-verify](https://github.com/danielfdickinson/image-handling-mod-hugo-dfd/actions/workflows/build-and-verify.yml/badge.svg)

## GitHub Repository

<https://github.com/danielfdickinson/image-handling-mod-hugo-dfd>

## Features

* From Hugo content files
  * via a render-image hook
  * via a shortcode
* TODO: #6 Cover images
* Microformat (e.g. Open Graph/Twitter) support (in combination with [DFD Hugo Microformats Module](https://github.com/danielfdickinson/hugo-dfd-microformats) via [DFD Hugo Metadata Module](https://github.com/danielfdickinson/hugo-dfd-metadata-central),
* Thumbnails (e.g. for blog/taxonomy/HTML sitemap/etc listings)
  * Configurable between thumbnail and full width or height image
  * Sitewide defaults
* Fallback for non-resource images
* Image conversion (e.g. to webp)
* Allow adding a wrapping link to original size image 
  * (optionally original format image)
* Configurable responsive behaviour (sizes attribute and sizes of images)
* Allow disabling responsive (autoselection of differently sized) images

## Basic Usage
### Importing the Module

1. The first step to making use of this module is to add it to your site or theme.  In your configuration file:

   ``config.toml``
   ```toml
   [module]
     [[module.imports]]
       path = "github.com/danielfdickinson/hugo-dfd-responsive-images"
   ```
   OR
   ``config.yaml``
   ```yaml
   module:
     imports:
       - path: github.com/danielfdickinson/hugo-dfd-responsive-images
   ```
2. Execute
   ```bash
   hugo mod get github.com/danielfdickinson/hugo-dfd-responsive-images
   hugo mod tidy
   ```

### Add the Image

1. Place your image (e.g. ``screenshot.png``) in a [Page Bundle](https://gohugo.io/content-management/page-bundles/)
   * **NB** You can only use subdirectories with leaf bundles. For branch bundles the image must be in the same directory as the ``_index.md``.
2. OR under ``assets`` in your project root (in which case you can use subdirectories under ``assets`` (e.g. ``assets/path/to/screenshot.png``))

**NB** If you don't use a page bundle or ``assets`` (e.g. if you place the image under ``static``, the image will still be used, but will not be responsive).

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
    height: unset;
    width: none;
    margin: 0;
    max-height: none;
    max-width: none;
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

See [partial below](#wrapped-image) for the full set of parameters you can use with the shortcode.
## Advanced Usage

### Responsive Images Partials

#### Wrapped Image

You have access to the ``helpers/responsive-images/wrapped-image`` partial in your layouts and shortcodes.
Not all combinations of parameters make sense.

```html
{{ partial "helpers/responsive-images" (
    dict "width" 1920px
    "height" 1080px
    "thumbnailwidth" "90px"
    "thumbnailheight" ""
    "alt" "Screenreader text"
    "title" "Title (screenreaders and often tooltip)"
    "src" "Image source (usually relative to page bundle or assets)"
    "page" .Page (Hugo page context; it is unlikely  that you will want this to be other than .Page)
    "link" "A link in which to wrap the image"
    "target" "For link: E.g. ('_blank')"
    "rel" "For link: E.g. ('nofollow')"
    "imagewrapper" "element in which to wrap <img> element"
    "caption" "A <figcaption> if image wrapper is <figure>, <span> if there is no title, or <div> if there is a title (because title will be wrapped in an <h2>"
    "attr" "More caption text (but can be wrapped by a hyperlink via attrlink)"
    "attrlink" "A hyperlink wrapped around attr in the element around a caption (e.g. \<figcaption>"
    "class" "Classes (space separated string) to add to the wrapper element, or the img element if there is no image_wrapper"
    "noImageWrapper" (If true you get a bare <img> element; default for render-image render hook)
    "imagesizes" "A slice of widths to use for the srcset"
    "thumbnailsizes" "A slice of width to sue for thumbnail srcset"
    "singlesize" "If true ignore srcset and *sizes; non-responsive img"
    "convertto" "image format to which to convert (for this call only)"
    "thumbnails" "If true generate thumbnails; if fullsize is also true use a 'picture' element to pick the set of images (thumbnails or full size, based on screen size)
    "fullsize" "If true generate full size images; see thumbnails"
    "sizesattr" "Overrides img (or source) 'sizes=' attribute"
    "thumbnailsizesattr" "As with sizesattr but for thumbnails"
    "minthumbnailviewport" "Minimum size of the viewport that is require to display thumbnails instead of full images"
    "loading" "If set, is the 'loading=' attribute for the 'img'"
    )
-}}

```

### Site or Page Params

| Param | Default | Description |
|-------|---------|-------------|
| imageResponsive | true | Make images responsive (have srcset and sizes) |
| imageLinkFull | _(nil)_ | Link in which to wrap image if not provided by shortcode or partial (always applies to markdown images) |
| imageAddWrapper | _(nil)_ | Element in which to wrap image if not provided by shortcode or partial (always applies to markdown images) |
| imageAddClass | _(nil)_ | Classes (space separated string) to add to wrapper element or img element if no image wrapper |
| imageAltAsCaption | false | Use alt text as caption when using image wrapper (unless caption specified) |
| imageConvertTo | _(nil)_ | Convert all images to specified format (must be an a format supported by Hugo; "webp" requires Hugo Extended) |

## Examples

### Test Image #1

#### Source
<https://github.com/danielfdickinson/hugo-dfd-responsive-images/blob/main/exampleSite/content/post/testimage1/index.md>

#### CSS

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result

![Image shows three different styling variations on a screenshot of a website](README-images/testimage1-result-screenshot.png)

### Test Image #2

#### Source
<https://github.com/danielfdickinson/hugo-dfd-responsive-images/blob/main/exampleSite/content/post/testimage2/index.md>

#### CSS

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result

![Image shows four different styling variations on a screenshot of a website](README-images/testimage2-result-screenshot.png)

### Test Image #3

#### Source
<https://github.com/danielfdickinson/hugo-dfd-responsive-images/blob/main/exampleSite/content/post/testimage3/index.md>

#### CSS

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result

![Image shows four different styling variations on a screenshot of a website](README-images/testimage3-result-screenshot.png)

### Test Thumbnails #1

#### Source
<https://github.com/danielfdickinson/hugo-dfd-responsive-images/blob/main/exampleSite/content/post/test-thumbnails-1/index.md>

#### CSS

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result

![Image shows three image thumbnails in a row (with large amounts space between them)](README-images/testthumbnails1-result-screenshot.png)

### Test Thumbnails #2

#### Source
<https://github.com/danielfdickinson/hugo-dfd-responsive-images/blob/main/exampleSite/content/post/test-thumbnails-2/index.md>

#### CSS

Which uses [the above CSS](#add-css-to-style-the-images) and ``imageConvertTo = "webp"`` in ``config.toml``

#### Result

![Image shows three image thumbnails in a row (with some space between them)](README-images/testthumbnails2-result-screenshot.png)
