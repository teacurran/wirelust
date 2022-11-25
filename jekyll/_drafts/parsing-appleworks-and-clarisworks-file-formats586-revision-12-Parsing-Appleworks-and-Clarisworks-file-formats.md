---
id: 600
title: 'Parsing Appleworks and Clarisworks file formats'
date: 2013-01-17 01:46:49
author: Tea
layout: revision
guid: 'http://www.wirelust.com/2013/01/17/586-revision-12/'
permalink: '/?p=600'
---

Over the past few years, when I have downtime, I sometimes like to reverse engineer abandoned file formats. It is kind of like working on a crossword puzzle with the bonus that any progress you make helps people out there who are trying to archive, index, or convert their old files.

I've spent a lot of time trying to figure out file format for Appleworks and Clarisworks. My latest efforts have been to take a file, make a small change, then use [Hex Fiend](http://ridiculousfish.com/hexfiend/) to compare what has changed in the binary format.

After years of off and on tinkering and documenting I finally wrote a basic parser for Appleworks and Clarisworks word processor files. I figured out a lot about the file format, but it still has a long way to go. You can view my current documenting status [here](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks) and download source for the parser on [GitHub](https://github.com/teacurran/appleworks-parser).

[![output of hex fiend comparing two files](http://www.wirelust.com/blog/wp-content/uploads/2013/01/hexfiend-286x300.png)](http://www.wirelust.com/blog/wp-content/uploads/2013/01/hexfiend.png)

[![output of parse](http://www.wirelust.com/blog/wp-content/uploads/2013/01/parse_output-300x273.png)](http://www.wirelust.com/blog/wp-content/uploads/2013/01/parse_output.png)

[![](http://www.wirelust.com/img/famfamicons/icons/link.png)](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks) [Link to file format research](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks)

[![](http://www.wirelust.com/img/famfamicons/icons/page_white_put.png)](https://github.com/teacurran/appleworks-parser) [Download source code at GitHub](https://github.com/teacurran/appleworks-parser)