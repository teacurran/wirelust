---
id: 19
title: 'I spoke too soon'
date: 2007-12-14 01:05:49
author: Tea
layout: post
guid: 'http://www.wirelust.com/2007/12/14/i-spoke-too-soon/'
permalink: /2007/12/14/i-spoke-too-soon/
aktt_notify_twitter:
    - 'no'
dsq_thread_id:
    - '849975588'
categories:
    - apple
---

Of course, as soon as I post about [my OSX kernel panics being fixed](http://www.wirelust.com/2007/12/13/osx-kernel-panic-part-ii/), there it is again. This definitely has something to do with networking, but it is tough to tell with all the layers.

I am using:

- WiFi (with patched 802.11n firmware)
- Wired Ethernet
- [Tunnelblick](http://www.tunnelblick.net/) (OpenVPN)
- Parallels Shared Networking

The crash always seems to occur, but not consistently:

- When switching from WiFi to Ethernet, or the other way around
- When Tunnelblick connection is dropped unexpectedly
- When switching from shared to host only networking in Parallels

I am going to try my best to recreate the issue consistently soon and be done with it for good.

Update (1/30/2008):  
Upgrading my version of Parallels to 3.0, build 5582 has fully fixed the problem once and for all. It has now been over 30 days without a Kernel Panic!