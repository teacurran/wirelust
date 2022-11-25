---
id: 611
title: 'Parsing Appleworks and Clarisworks file formats'
date: 2013-01-17 01:58:16
excerpt: 'After years of off and on tinkering and documenting I finally wrote a basic parser for Appleworks and Clarisworks word processor files. I ''believe'' this is the first free and open parser for this file format, even if it is ten years too late.'
layout: revision
guid: 'http://www.wirelust.com/2013/01/17/586-revision-21/'
permalink: '/?p=611'
---

Over the past few years, when I have downtime, I sometimes like to reverse engineer abandoned file formats. It is kind of like working on a crossword puzzle with the bonus that any progress you make helps people out there who are trying to archive, index, or convert their old files.

[![output of hex fiend comparing two files](http://www.wirelust.com/blog/wp-content/uploads/2013/01/hexfiend-286x300.png)](http://www.wirelust.com/blog/wp-content/uploads/2013/01/hexfiend.png)

I've spent a lot of time trying to figure out file format for Appleworks and Clarisworks. My latest efforts have been to take a file, make a small change, then use [Hex Fiend](http://ridiculousfish.com/hexfiend/) to compare what has changed in the binary format.

After years of off and on tinkering and documenting I finally wrote a basic parser for Appleworks and Clarisworks word processor files. I ‘believe' this is the first free and open parser for this file format, even if it is ten years too late. I figured out a lot about the format, but it still has a long way to go. You can view my current documenting status [here](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks) and download source for the parser on [GitHub](https://github.com/teacurran/appleworks-parser).

The parser so far can read:

- document version
- page size
- margins
- document content

[![output of parse](http://www.wirelust.com/blog/wp-content/uploads/2013/01/parse_output-300x273.png)](http://www.wirelust.com/blog/wp-content/uploads/2013/01/parse_output.png)

From what I have seen, most people trying to read Appleworks documents only really care about the document content, but I am very close to figuring out how to parse:

- styles – (bold, italic, underline)
- footnotes

I may not touch it again for another year, but who knows.

[![](http://www.wirelust.com/img/famfamicons/icons/link.png)](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks) [Link to file format research](http://wiki.wirelust.com/x/index.php/AppleWorks_/_ClarisWorks)

[![](http://www.wirelust.com/img/famfamicons/icons/page_white_put.png)](https://github.com/teacurran/appleworks-parser) [Download source code at GitHub](https://github.com/teacurran/appleworks-parser)