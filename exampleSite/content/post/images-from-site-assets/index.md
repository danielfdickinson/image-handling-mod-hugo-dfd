---
title: "Images From Site Assets"
date: 2022-01-03T01:57:06Z
publishDate: 2022-01-03T01:57:06Z
author: Daniel F. Dickinson
tags:
    - featured
    - images
images:
    - [dont-break-the-back-button.svg, "A black backwards pointing arrow with a red \"stop\" circle over the top"]
    - [/substatic/featured-favicon-ascface-512x512.png, "squarish ASCII art smiley"]
    - ["https://media.istockphoto.com/photos/young-woman-watches-sunrise-outside-camping-tent-picture-id1248575497?s=612x612", "young woman watches sunrise outside camping tent"]
---

## Frontmatter images

Based on the following frontmatter, there should be two. The second one is loaded from a remote source (<https://istockphoto.com>). The static image is ignored because static images are only processed if no resource images are found.

The displayed images from frontmatter should be full width to a maximum of screen width.

See [README.md—Featured images](../README.md#featured-images)

``` yaml
images:
    - [dont-break-the-back-button.svg, "A black backwards pointing arrow with a red 'stop' circle over the top"]
    - [/substatic/featured-favicon-ascface-512x512.png, "squarish ASCII art smiley"]
    - ["https://media.istockphoto.com/photos/young-woman-watches-sunrise-outside-camping-tent-picture-id1248575497?s=612x612", "young woman watches sunrise outside camping tent"]

```

The static image

{{< show-featured-images "metadata" >}}

## Static image

### Markdown

![squarish ASCII art smiley face](/substatic/featured-favicon-ascface-512x512.png)

### Figure

{{< figure class="a-test-class" imageClass="per-image-class" alt="squarish ASCII art smiley face" src="/substatic/featured-favicon-ascface-512x512.png" ignoreStaticImages="false" >}}
