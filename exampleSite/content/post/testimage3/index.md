---
title: "Test Image #3"
date: 2021-10-20T11:01:34Z
publishDate: 2021-10-20T11:01:34Z
categories:
    - Markdown Images
tags:
    - Example Post
author: "Daniel F. Dickinson"
imageAltAsCaption: true
imageAddClass: markdown-image-wrapper
weight: 30
---

## Via Markdown

no wrapper, alt as caption:

![Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera](cappy-on-bed.jpeg)

## Via figure shortcode (but \<div> as wrapper)

{{< figure class="responsive-div" imagewrapper="div" title="Figure 1: Differences between markdown figures and figure shortcode" src="cappy-on-bed.jpeg" alt="Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera" caption="For a figure caption can be different than alt text">}}

## Via figure shortcode (originalheight)

{{< figure class="responsive-figure-originalheight" singleSize=true title="Figure 1: Differences between markdown figures and figure shortcode (original height)" src="cappy-on-bed.jpeg" alt="Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera (no caption specified so alt as caption)">}}

## Via figure shortcode (fullwidth)

{{< figure class="responsive-figure fullwidth" title="Figure 1: Differences between markdown figures and figure shortcode (full width)" src="cappy-on-bed.jpeg" alt="Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera (no caption specified so alt as caption)">}}

## Via figure shortcode (GrowFit)

{{< figure class="responsive-figure" fullSize=true singleSize=true title="Figure 1: Differences between markdown figures and figure shortcode" src="cappy-on-bed.jpeg" alt="Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera (no caption specified so alt as caption)" imageConvertMethod="GrowFit" height=1200 width=1800 >}}

## Via figure shortcode (GrowFit) no CSS

{{< figure class=" " fullSize=true singleSize=true title="Figure 1: Differences between markdown figures and figure shortcode" src="cappy-on-bed.jpeg" alt="Yorkshire Terrier Poodle cross (dog) curled up on a duvet and looking towards camera (no caption specified so alt as caption)" imageConvertMethod="GrowFit" height=1200 width=1800 >}}
