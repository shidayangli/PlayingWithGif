PlayingWithGif
===========================

由于iOS上没有现成的直接加载gif的控件，所以总结了我所知道的所有的加载gif的方法，可以借鉴了解。

由于用到了image IO框架，所以会涉及Core Foundation框架，要先做一些准备工作。

# 关于__bridge,__bridge_retained和__bridge_transfer的用法

## __bridge只做类型转换，但是不修改对象（内存）管理权;
## __bridge_retained（也可以使用CFBridgingRetain）将Objective-C的对象转换为Core Foundation的对象，同时将对象（内存）的管理权交给我们，后续需要使用CFRelease或者相关方法来释放对象;
## __bridge_transfer（也可以使用CFBridgingRelease）将Core Foundation的对象转换为Objective-C的对象，同时将对象（内存）的管理权交给ARC。
