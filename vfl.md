Visual format notation(视觉符号格式)

另一种来缩写创建约束的方式是使用某种基于文本的速记，叫做视觉符号格式。这个可以让你同步的描述多种约束。它也是特别具体的当你安排一系列竖直方向或者水平方向的view的时候。我会以一个很简单的例子开头:

在上述表达中，`V:`代表论述下的`vertical deimension`，另一半选择是`H:`，它也是默认的（因此准许不指明尺寸）。一个view的名字出现在括号里，同时一个竖直符号表示`superview`，所以这里我们正在描绘v2的top edge顶住它superview的top edge。数字的符号表示参数，同时数字符号伴同view的名字设置view的尺寸，所以在这里我们设置v2的height为10。
使用visual format，你不得不提供一个字典来装上面提到的view的名字字符。例如：使用之前表达的字典可以为["v2":v2]。所以这里还有之前表达的另一种方式，使用visual format的简称。

```Swift
let d = ["v2":v2, "v3":v3]
NSLayoutConstraint.activateContraints([
  NSLayoutConstraint.constraintWithVisualFormat("H:|[v2]|", options: [], merics: nil, views: d),
  NSLayoutConstraint.constraintWithVisualFormat("V:|[v2(10)]", options: [], merics: nil, views: d),
  NSLayoutConstraint.constraintWithVisualFormat("H:[v3(20)]|", options: [], merics: nil, views: d),
  NSLayoutConstraint.constraintWithVisualFormat("V:[v3(20)]|", options: [], merics: nil, views: d)
  ].flatten().map{$0})
```

metrics: 参数是一个有用数字的字典。这可以让你使用一个visual format string的名字。
options: 参数是一个bitmask(NSLayoutFormatOptions), 主要让你做一些事情，例如添加alignments。alignments被应用在所有在visual format中提到的views。

为了具体地别是两个连续的view之间的距离，使用连字符-环绕在数字符号周围，像：“[v1]-[20]-[v2]”。数字可以选择性的使用括号[]包围。
一个在括号中的数字可能会地位高于一个同等的或者不同等的操作符。同时也可以跟随一个@符号表示priority。被逗号,分割的多种数字，也可以出现在参数中。例如[v1(>=20@400, <=30)]

想要了解更多关于visual format语法,请查看"Apple's Auto Layout Guide"一章中的"Visual Format Syntax"

文／上天遁地（简书作者）
原文链接：http://www.jianshu.com/p/e7c7a2cd4735
著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。