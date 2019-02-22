
---
title: 第八章-Goroutines-和Channels
date: 2019-02-19 14:21:37
categories:
- 提升
- 语言
tags: 
- golang
---

*PS--书本读到这里，已经敢写一些自己的东西了，之前不敢写是因为实在觉得自己是一个求学者，带着学习的态度，能把书上的东西学到几成已经是大不易了，添自己的东西进来，如果是画蛇添足都是万幸，那还不如不加，之所以敢写了现在，是因为不断的学习，让我敢于对一部分知识进行自我阐述，如果不对，希望能够得到谅解，我会将自己的话语用花括号括起来，如果有幸对于阅读有帮助，那么真的是非常荣幸的事情。*
* * *
####Goroutines 
在GO语言中，每一个并··发的执行单元叫做一个goroutine。
当一个程序启动时，其主函数即在一个单独的goroutine中运行，屋门叫它 main goroutine，新的goroutine会用go语句来创建。 go语句就是一个普通的函数或者方法前加上关键字**go**。｛go语言并发中的进程块｝
####Channels
如果说goroutine是go程序啊并发体的话，channels就是它们之间的通信机制。｛可以理解为goroutines 之间的信息通信管道｝
~~~
ch := make(chan int)//信息通信管道中传递的是int类型的数据。
~~~
channel的零值是nil 。两种相同类型的channel可以使用==符号进行比较。一个channel有发送和接受两个操作都是用<-运算符。在发送语句中该运算符分割channel和要发送的值，在接受语句中,<-运算符写在channel对象之前，一个不使用接收结果的接收操作也是合法的。
~~~
ch<-x //一个发送操作  将x发送到管道ch中。、
x = <-ch //一个接收操作  将管道输出的值，赋值给X，相当于x接收了管道的值
<-ch  //接受操作
close(ch)//使用内置的close函数就可以关闭一个channel

ch = make(chan int) //创建一个不带缓存的通道
ch = make(chan int,0) //创建一个不带缓存的通道
ch = make(chan int,3) //创建一个带缓存缓存块大小为3的通道
~~~
####不带缓存的Channels
基于无缓存的channels的发送和接收操作将导致两个goroutine做一次同步操作。因为这个原因，无缓存的channle有时候也被成为同步Channels，当通过一个无缓存的channel发送数据的时候，接收者收到数据发送在唤醒发送者goroutine这个情况叫做happens before，注意这种问题主要是因为goroutine的运行都是相对独立的，如果不能同步结束或者未通知会导致goroutine一直运行下去。
Channels可以用于将多个goroutines 链接在一起，也同样可以一个Channles的输出作为下一个Channel的输入。这种串连的Channels就是所谓的管道。
~~~
close(channel)//关闭某个通信
~~~
没有办法直接测试一个通信是否被关闭，但是接受操作可以接收第二个参数，返回的布尔值确定是否成功从通信中接收到数据。

channel是不需要去特意关闭全部的，只要当需要告诉接收者goroutine,所有的数据都已经发送完毕的时候才需要关闭，不管一个通信是否被关闭，当它没有被引用的时候都会被垃圾回收机制回收。另，重复关闭一个通信会报错，试图关闭nil值的通信也会出现panic关闭一个channel还会触发一个广播机制。
｛**这里需要记忆区别，channel是不需要特意的去关闭的，因为垃圾回收会处理，但是goroutines是需要特别处理，主goroutine关闭前，记得关闭其他的子goroutine，避免泄漏的发生**｝
当channel作为参数传递的时候，总是专门被用作接收或者发送的。为了防止意图被滥用，特有chan变种 chan<-int  和 <-chan int分别表示只发送和只接收。
####带缓存的channels
带缓存的channel内部持有一个元素队列。声明方式如下：
~~~
ch = make(chan string ,3)
//获取缓存容量
cap(ch)
//获取当前通道长度
len(ch)
~~~
当三个goroutines 共用一个channel取值时，如果使用无缓存的channel可能会导致快的一个goroutine一直在取值，而其他两个goroutine一直处于等待状态，这种状态叫做**goroutines泄漏**这是一个BUG，不会被回收机制自动回收。


