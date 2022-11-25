---
id: 337
title: '[snippit] &#8211; generating a faux waveform in AS3'
date: 2009-12-08 16:20:06
author: Tea
layout: revision
guid: 'http://www.wirelust.com/2009/12/08/326-revision-11/'
permalink: '/?p=337'
---

Working on a project. I had to use the microphone to record some audio and generate a simple waveform so the user has some feedback that they are being heard. While not a true waveform, you can use the microphone activity level to generate something that works pretty well.

\[kml\_flashembed publishmethod=”static” fversion=”9.0.0″ movie=”http://www.wirelust.com/examples/waveform/bin-debug/waveform.swf” width=”500″ height=”250″ targetclass=”flashmovie”\]

[![Get Adobe Flash player](http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif)](http://adobe.com/go/getflashplayer)

\[/kml\_flashembed\]

Here is the code to generate the above sample:

```actionscript
// loopback is required so we can get the activity level and create the waveform. - so stupid
<span style="color: #808080; font-style: italic;">// turn off the volume for the loopback</span>
 
```

And for the Waform class:

```actionscript
// trim the levels so we don't keep eating up memory
<span style="color: #808080; font-style: italic;">// autoscale will find the highest volume and scale all lines in the display accordingly.</span>
 
```

### Files

[![](http://www.wirelust.com/img/famfamicons/icons/page_white_put.png)](http://www.wirelust.com/examples/waveform/waveform.zip) [Download source code](http://www.wirelust.com/examples/waveform/waveform.zip)