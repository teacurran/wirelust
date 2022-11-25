---
id: 87
title: 'Removing Parallels hdd lock file'
date: 2008-12-16 14:57:17
author: Tea
layout: post
guid: 'http://www.wirelust.com/?p=87'
permalink: /2008/12/16/removing-parallels-hdd-lock-file/
aktt_notify_twitter:
    - 'no'
dsq_thread_id:
    - '478884795'
categories:
    - apple
tags:
    - parallels
---

Parallels crashed on me this afternoon while Windows was installing patches and rebooting. When I tried to start the system up again I kept getting this error message:

> Parallels Desktop is unable to access the virtual hard disk image file winxp3.hdd. The file is missing, corrupted, or used by other application.

I knew that the file wasn't in use by any other application because Parallels was no longer running and I had rebooted my machine.

It took a bit of digging, but here is how to make it stop thinking the file is in use:

– Locate your .hdd file (usually in ~/Library/Parallels)  
– Right click on the file and choose “Show Package Contents”  
![](/img/entries/parallels_lock_file_1.png)

When the package is opened, look for a file called “DiskDescriptor.xml.lck”. This is the file it uses to determine if the disk image is in use. Toss this file in the trash and close the package. Parallels should now start up.  
![](/img/entries/parallels_lock_file_2.png)