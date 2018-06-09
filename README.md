# Windows Stylus (Pen) Button Gesture .ahk
Script that makes gestures available when button hovering on Tablet PC. 

## Document
[Korean](https://github.com/PBW99/StylusButtonGesture-AutoHotkey/blob/master/README-kr.md)

[English](https://github.com/PBW99/StylusButtonGesture-AutoHotkey/blob/master/README.md)
 
## Objective
 Windows allows you to use mouse gestures in various programs ([StrokeIt](https://www.tcbmi.com/strokeit/), [GestureSign](https://www.microsoft.com/en-us/p/gesturesign/9n45wqvk2qqw)). However, the stylus (pen) doesn't work with these gestures. This Program makes it by allowing mouse gestures during **Hovering** stylus(pen) with pressing button.


## Demo
[![Alt text for your video](https://img.youtube.com/vi/J68ZjTOJFds/0.jpg)](https://www.youtube.com/watch?v=J68ZjTOJFds&feature=youtu.be)

## Install
Install [AutoHotkey](https://autohotkey.com/) and run Pen.ahk. The Pen.ahk script will run only if the [AHKHID.ahk](https://github.com/jleb/AHKHID) script is in the same folder.

## How to use 
* During Pen Hovering, press and hold the second button of the pen and execute the mouse gesture. The buttons in the mouse gesture program are based on **right-click**.
* During Pen Hovering, double click the 2nd button make the {WIN + TAB} button  pressed to activate the app switcher.

## Algorithm
If the Pen is hovering on the screen in the WindowsOS, the mouse will follow to that coordinates. However, in Chrome and certain apps, the pen's coordinates and mouse's coordinates do not match, so they're set to move apart. Because of this, I made two coordinates matched.


## Acknowledgements
* [TheGood (AHK Forums)](https://autohotkey.com/board/topic/38015-ahkhid-an-ahk-implementation-of-the-hid-functions/) / [jleb (Github)](https://github.com/jleb/AHKHID) for writing AHKHID.
* [Randy31416 (AHK Forums)](https://autohotkey.com/boards/viewtopic.php?t=7589#p45235) for providing some good starting material.
* [Surface-Pro-AutoHotkey](https://github.com/jonathanyip/Surface-Pro-3-AutoHotkey)
