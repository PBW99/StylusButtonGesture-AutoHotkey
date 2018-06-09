#윈도우 스타일러스(펜) 버튼 제스처.ahk
2 in 1 태블릿 PC에서 버튼 Hovering시에 제스처를 사용가능하게 해주는 스크립트입니다.

## 목적
윈도우에서는 마우스 제스처를 다양한 프로그램([StrokeIt](https://www.tcbmi.com/strokeit/), [GestureSign](https://www.microsoft.com/en-us/p/gesturesign/9n45wqvk2qqw))을 통해 사용할 수 있습니다. 하지만 스타일러스(펜)는 이와 같은 제스처가 동작하지 않기에 만들게 되었습니다. 스타일러스(펜) **Hovering**시에 마우스 제스처를 사용할 수 있게 하였습니다.


## 실행영상
<iframe width="560" height="315" src="https://www.youtube.com/embed/J68ZjTOJFds" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

## 사용방법
* Pen Hovering시에 Pen의 2번째 버튼을 누른 상태에서 마우스 제스처를 실행하면 됩니다. 마우스 제스처 프로그램의 버튼은 **오른쪽 클릭**을 기준으로 작성 되었습니다.
* Pen Hovering시에 2번째 버튼을 더블클릭하면 {WIN + TAB} 버튼이 눌러져, 앱스위처가 작동합니다.

## 알고리즘
윈도우 내에서 Pen이 화면에 Hovering하는 경우에 마우스가 그 좌표로 움직이게 되어있습니다. 하지만 Chrome및 특정 앱에서는 Pen의 좌표와 마우스의 좌표가 일치하지 않고, 따로 움직이도록 설정이 되어있습니다. 이 때문에 좌표를 일치시켜주었습니다.


## Acknowledgements
* [TheGood (AHK Forums)](https://autohotkey.com/board/topic/38015-ahkhid-an-ahk-implementation-of-the-hid-functions/) / [jleb (Github)](https://github.com/jleb/AHKHID) for writing AHKHID.
* [Randy31416 (AHK Forums)](https://autohotkey.com/boards/viewtopic.php?t=7589#p45235) for providing some good starting material.
* [Surface-Pro-AutoHotkey](https://github.com/jonathanyip/Surface-Pro-3-AutoHotkey)
