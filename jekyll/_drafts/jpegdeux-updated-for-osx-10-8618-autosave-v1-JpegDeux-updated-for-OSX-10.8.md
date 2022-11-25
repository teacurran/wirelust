---
id: 672
title: 'JpegDeux updated for OSX 10.8'
date: 2020-01-03 15:12:36
author: Tea
layout: revision
guid: 'http://www.wirelust.com/2020/01/03/618-autosave-v1/'
permalink: '/?p=672'
---

![JPEGDeux logo](/apps/JPEGDeux/jpegdeux_1.png)  
It's been a long time since I've wanted to show a simple photo slideshow on OSX. Back in the day I feel like i had to do this more often. I remembered that I used to either use [Graphic Converter](http://www.lemkesoft.de/en/start/) or a simpler program called [JPEGDeux](http://sourceforge.net/projects/jpegdeux/).

I had to do a photo slideshow today, so I went to download one of these programs to do it. Graphic Converter was a 150MB download and I was on LTE so it wasn't downloading quick enough. JPEGDeux, unfortunately, downloaded but wouldn't work on my version of OSX. In fact it looks like they only have binaries for PPC versions of OSX less than 10.3.

![JPEGDeux logo](/apps/JPEGDeux/jpegdeux_3.png)  
Well, I had to fix this. I downloaded the [source](http://sourceforge.net/projects/jpegdeux/) for JPEGDeux and spent the afternoon updating it and getting it to compile again. It used an old XCode project format and a lot of out-dated carbon APIs that aren't supported anymore. After more time than I hoped I would have spent, it is now working again. I disabled the Quicktime option because that would have required re-writing large amounts of code to work with CoreImage, but it works just fine without the Quicktime option on modern hardware.

I uploaded the code to GitHub because Sourceforge makes me sad.

Please report any issues you have running this. I have only tried it on my mac so far. And if you have the means, please fork and help out with the code.

### Files

[![](http://www.wirelust.com/img/famfamicons/icons/page_white_put.png)](http://www.wirelust.com/apps/JPEGDeux/JPEGDeux_1.9.dmg) [Download a compiled Binary](http://www.wirelust.com/apps/JPEGDeux/JPEGDeux_1.9.dmg)  
[Download source at Github](https://github.com/teacurran/JpegDeux)