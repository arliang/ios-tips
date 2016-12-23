#16-12-09

1. 使用`UIScrollView`使得界面可以滚动 ☑️ 可以滚动了，但是计算高度出现了点问题
   1. 导致`imageView`无法识别左右滑动的手势了
2. 使用`UITabBarController`添加底部导航栏 在`navigatorController`里面有个`toolBar`，可以用来代替这个

# ios 添加speak方法提供给html调用 !important . 完成


HBuilder 报错
result?.toJSONString()

String类型的失败了，不知何故

object-c版未测试

PDRPluginResult *resultInt32 = [PDRPluginResult resultWithStatustatus: PDRCommandStatusOK, messageAsInt: 123 as Int32)];
PDRPluginResult *resultString = [PDRPluginResult resultWithStatustatus: PDRCommandStatusOK, messageAsString: "123 as Int32")];
PDRPluginResult *resultDouble = [PDRPluginResult resultWithStatustatus: PDRCommandStatusOK, messageAsDouble: 123 as Double)];
PDRPluginResult *resultDic = [PDRPluginResult resultWithStatustatus: PDRCommandStatusOK, messageAsDictionary: ["A": "B"])];


[resultInt32 toJSONString]
[resultString toJSONString]
[resultDouble toJSONString]
[resultDic toJSONString]


websocket 使用 node-websocket

ios 使用 SwiftSocket


old: connecting -> new: connecting
old: connecting -> new: connecting
Websocket is disconnected. Error: Could not find app by key YOUR_APP_KEY. Perhaps you're connecting to the wrong cluster.

使用推送 进行声音播报