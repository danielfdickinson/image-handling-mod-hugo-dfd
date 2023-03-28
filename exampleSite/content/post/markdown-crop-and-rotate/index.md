---
title: "Markdown or shortcode crop and rotate"
date: 2023-03-28T21:43:42Z
publishDate: 2023-03-28T21:43:42Z
author: Daniel F. Dickinson
tags:
    - images
imageMarkdownAddWrapper: true
imageAddWrapper: span
imageMarkdownClass: markdown-image-wrapper-no-style
imageLinkFull: true
---

## Cropped and rotated image (Markdown)

```markdown
![Photo of a rock garden with tulips and rust-coloured plants, cropped and rotated]\(backgarden-tulips+rocks.png?m=Crop&r=335&w=600&h=480&a=center)
```

![Photo of a rock garden with tulips and rust-coloured plants, cropped and rotated](backgarden-tulips+rocks.png?m=Crop&r=335&w=600&h=480&a=center)

## Cropped and rotated image (shortcode)

```go
{{</* figure singlesize=true imageConvertMethod=Crop width=600 height=480 anchor=center rotation=335 title="Figure 1: Differences between markdown figures and figure shortcode" src="backgarden-tulips+rocks.png" alt="Photo of a rock garden with tulips and rust-coloured plants" */>}}
```

{{< figure singlesize=true imageConvertMethod=Crop width=600 height=480 anchor=center rotation=335 title="Figure 1: Differences between markdown figures and figure shortcode" src="backgarden-tulips+rocks.png" alt="Photo of a rock garden with tulips and rust-coloured plants">}}

## Original image

![Photo of a rock garden with tulips and rust-coloured plants](backgarden-tulips+rocks.png)
