---
title: "Test Image #2"
date: 2021-10-19T09:36:25Z
publishDate: 2021-10-19T09:36:25Z
categories:
    - Markdown Images
tags:
    - Example Post
author: "Daniel F. Dickinson"
imageLinkFull: true
imageAltAsCaption: true
imageMarkdownAddWrapper: true
imageAddWrapper: span
imageMarkdownClass: markdown-image-wrapper
weight: 20
---

## Via Markdown

span wrapper, alt as caption:

![Photo of a rock garden with tulips and rust-coloured plants](backgarden-tulips+rocks.png)

## Via figure shortcode (but \<div> as wrapper)

{{< figure class="responsive-div" imagewrapper="div" title="Figure 1: Differences between markdown figures and figure shortcode" src="backgarden-tulips+rocks.png" alt="Photo of a rock garden with tulips and rust-coloured plants" caption="For a figure caption can be different than alt text">}}

## Via figure shortcode (originalheight)

{{< figure class="responsive-figure-originalheight" singlesize=true title="Figure 1: Differences between markdown figures and figure shortcode (original height)" src="backgarden-tulips+rocks.png" alt="Photo of a rock garden with tulips and rust-coloured plants (no caption specified so alt as caption)">}}

## Via figure shortcode (fullwidth)

{{< figure class="responsive-figure fullwidth" title="Figure 1: Differences between markdown figures and figure shortcode (full width)" src="backgarden-tulips+rocks.png" alt="Photo of a rock garden with tulips and rust-coloured plants (no caption specified so alt as caption)">}}
