# Tips about iOS dev

## FAQ

### **Q:** Pod install, The dependency \`*****\` is not used in any concrete target

http://stackoverflow.com/questions/40234810/pod-install-the-dependency-is-not-used-in-any-concrete-target

**A:** Your `Podfile` should contain in which target you want to install the
cocoapods. The post installer in your Podfile setting only `ACTIVE_ARCH` flag to
`NO` in each target.

If you have more than 20 targets in your app, maybe try to remove `Podfile` and
`Podfile.lock` and do `pod init` then CococaPods gem create a valid `Podfile` for
your app. Then paste the cocoapods that your app using and paste the post
installer instruction to the new Podfile and try to resinstall cocoapods using
`pod install`

Look at the [CocoaPods site](https://guides.cocoapods.org/syntax/podfile.html) about Podfile.

So your Podfile should look like:

```ruby
target 'YourTargetName' do

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'

pod 'MMDrawerController', '~> 0.5.7'
pod 'ViewUtils'
pod 'CPAnimationSequence'
pod 'iCarousel'
pod 'BlocksKit', '~> 2.2.5'
pod 'AFNetworking'
pod 'MBProgressHUD', '~> 0.8'
pod 'NSString-UrlEncode'
pod 'INTULocationManager'
pod 'SDWebImage', '3.7.2'
pod 'Adjust', :git => 'https://github.com/adjust/ios_sdk.git', :tag => 'v3.4.0'
pod 'TARTT', :git => 'https://github.com/takondi/tartt-sdk-ios.git'
pod 'SIAlertView', '~> 1.3'
pod 'GoogleAppIndexing'
pod 'Gimbal'

post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end
end
```

----

xcode中的project.pbxproj冲突怎么解决
https://www.zhihu.com/question/19763504

----

使用`pod`的时候会有这个提示，是因为里面用了特别的引号`platform :ios, ‘8.1’`

>  Your Podfile has had smart quotes sanitised. To avoid issues in the future, you
>  should not use TextEdit for editing it. If you are not using TextEdit, you should
>  turn off smart quotes in your editor of choice.`

----

### **Q:** ld: warning: directory not found for option

http://stackoverflow.com/questions/9458739/ld-warning-directory-not-found-for-option

**A:**
**You need to do this:**

1.  Click on your project (targets)
2.  Click on **Build Settings**
3.  Under **Library Search Paths**, delete the paths

And regarding the second error, sorry i can't help you out with that one. Hope
someone else can help you out.

Good luck,
Nathan

----


### **Q:** `Swift` 中的`?` 和`!`

**A:** `?`是`Option`类型，需要用`!`解包

```js
var userLabel: UILabel?
userLabel = UILabel()
//...
self.view.addSubview(userLabel!)
```

### 遍历所有的子控件

```js
// http://blog.csdn.net/csgcsg123/article/details/46357617
for (UIView *child in view.subviews) {
  NSString *childXml = [self digView:child];
  [xml appendString:childXml];
}
```

### error

> Terminating app due to uncaught exception 'NSInternalInconsistencyException',
> reason: 'unable to dequeue a cell with identifier Cell - must register a nib
> or a class for the identifier or connect a prototype cell in a storyboard


```obj-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier]; // 是少了这一句代码
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // config cell
　XYZToDoItem * toDoItem = [self.toDoItem objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;

   return cell;
}
```


### CollectionView 设置

```swift
// 这个是CELL的宽度和高度，可以通过计算
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(yourWidth, yourHeight)
}

// collectionView的上下左右间距
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}

// 每个小单元的间距
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 0
}

// 单元的行间距
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return CGFloat(20.0)
}
```


### 使用`where`来进一步筛选

```swift
let score: [Int?] = [99, 100, nil, 60]
score.forEach {
    if let s = $0 where s == 100 {
        print("you are so smart!")
    }
}
```

### 获取顶部导航栏高度
iPhone开发当中，有时需要获取状态栏和导航栏高度、宽度信息，方便布局其他控件。下面介绍一下如何获取这些信息：
```obj-c
// 状态栏(statusbar)
CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
NSLog(@"status width - %f", rectStatus.size.width); // 宽度
NSLog(@"status height - %f", rectStatus.size.height); // 高度

// 导航栏（navigationbar）
CGRect rectNav = self.navigationController.navigationBar.frame;
NSLog(@"nav width - %f", rectNav.size.width); // 宽度
NSLog(@"nav height - %f", rectNav.size.height); // 高度
```

打印结果如下：

    2015-01-14 13:22:22.206 app_name[226:60b] status width - 320.000000
    2015-01-14 13:22:22.209 app_name[226:60b] status height - 20.000000
    2015-01-14 13:22:22.210 app_name[226:60b] nav width - 320.000000
    2015-01-14 13:22:22.211 app_name[226:60b] nav height - 44.000000

### 监听 `textField` 输入事件
```obj-c
[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}
```

### collectionView 需要实现的方法

```swift
// 每个 section 显示 cell 的数量
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
}
// 每个 view 显示 section 的数量
func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
}
```

### label 的一些拍版属性和方法

|                  | 作用                        |
 ----------------- | ----------------------------
|`label.adjustsFontSizeToFitWidth = true` |  根据**label大小**调整**文字大小**
|`label.sizeToFit()`| 自动调整**laibel大小**以适应内容宽度
|`label.adjustsFontForContentSizeCategory = true`| 未知

### 非https请求

iOS 9中默认非HTTS的网络是被禁止的，当然我们也可以把NSAllowsArbitraryLoads设置为YES禁用ATS。
不过iOS 10从2017年1月1日起苹果不允许我们通过这个方法跳过ATS，也就是说强制我们用HTTPS，如果不
这样的话提交App可能会被拒绝。但是我们可以通过`NSExceptionDomains`来针对特定的域名开放HTTP
可以容易通过审核。

NSExceptionDomains方式 设置域。可以简单理解成，把不支持https协议的接口设置成http的接口。

具体方法：

1. 在项目的`info.plist`中添加一个Key：`App Transport Security Settings`，类型为`字典`类型。

2. 然后给它添加一个`Exception Domains`，类型为`字典`类型；

3. 把需要的支持的域添加給`Exception Domains`。其中域作为Key，类型为`字典`类型。

4. 每个域下面需要设置3个属性： `NSIncludesSubdomains`、`NSExceptionRequiresForwardSecrecy`、
   `NSExceptionAllowsInsecureHTTPLoads`。

文／PengJiang（简书作者）

原文链接：http://www.jianshu.com/p/6c14428956b8

著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。

### Info.plist 配置自定义字体
`Info.plist`

    Fonts provided by application
      Item 0   zenicon.ttf

对应的xml标签是

    <key>UIAppFonts</key>
    <array>
        <string>zenicon.ttf</string>
    </array>

其中的值是不带路径的

### app的入口

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    }
    // 实现其他protocol
}
```

### `[[UIScreen mainScreen] bounds]`获取尺寸不对

解决办法1：(先在Images.xassets中创建LaunchImage,然后去ImageSource去选择)

解决办法是在Images.xcassets中创建LaunchImage，并将它做为Launch Images Source(点击Use
Asset Catalog,选择Imges Source，这前提是在Images.xcassets中先创建LaunchImage，这样才
能在Images Source检测到你创建的LaunchImage)


### assist editor打开的文件不对，可以在顶部导航栏第一项选 Manual 来指定

### 切换 `ViewController`

`UIApplication.sharedApplication().keyWindow?.rootViewController = CMTabBarController()`

### view 闪一下就不见的问题

```swift
@IBAction func enter(sender: UIButton) {
    let flowLayout = UICollectionViewFlowLayout()

    flowLayout.minimumLineSpacing = 20
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.itemSize = CGSize(width: 80, height: 120)
    flowLayout.scrollDirection = .Vertical

    flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    // 这个collection如果是本地变量可能会被回收，造成这个view闪一下就不见了。
    collection = CollectionViewController(collectionViewLayout: flowLayout)
    self.view.addSubview(collection!.view)
}
```


### 十六进制颜色

```swift
// http://blog.csdn.net/crystal300/article/details/52690994
// swift 3.0
func transferStringToColor(_ colorStr:String) -> UIColor {

    var color = UIColor.black
    var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

    if cStr.hasPrefix("#") {
        let index = cStr.index(after: cStr.startIndex)
        cStr = cStr.substring(from: index)
    }
    if cStr.characters.count != 6 {
        return color
    }

    let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
    let rStr = cStr.substring(with: rRange)

    let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
    let gStr = cStr.substring(with: gRange)

    let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
    let bStr = cStr.substring(from: bIndex)

    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rStr).scanHexInt32(&r)
    Scanner(string: gStr).scanHexInt32(&g)
    Scanner(string: bStr).scanHexInt32(&b)

    color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))

    return color
}
```

```swift
// swift 2.3
func transferStringToColor(colorStr: String, alpha: CGFloat = 1.0) -> UIColor {
    let color = UIColor.blackColor()
    var cStr: String = colorStr.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString

    if cStr.hasPrefix("#") {
        let index = cStr.startIndex.advancedBy(1)
        cStr = cStr.substringFromIndex(index)
    }

    if cStr.characters.count == 3 {
        cStr = cStr.characters.reduce("", combine: { $0 + String([$1, $1]) })
    }

    if cStr.characters.count != 6 {
        return color
    }

    let rRange=Range<String.Index>(start: cStr.startIndex, end: cStr.startIndex.advancedBy(2))
    let rStr = cStr[rRange]

    let gRange=Range<String.Index>(start: cStr.startIndex.advancedBy(2), end: cStr.startIndex.advancedBy(4))
    let gStr = cStr[gRange]

    let bRange=Range<String.Index>(start: cStr.startIndex.advancedBy(4), end: cStr.startIndex.advancedBy(6))
    let bStr = cStr[bRange]

    var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0

    NSScanner(string: rStr).scanHexInt(&r)
    NSScanner(string: gStr).scanHexInt(&g)
    NSScanner(string: bStr).scanHexInt(&b)

    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
}
```


### 快速转换图片大小

```bash
sips -Z 167 AppIcon.png --out out/AppIcon-167.png
```

    -z pixelsH pixelsW
    --resampleHeightWidth pixelsH pixelsW
        Resample image at specified size. Image apsect ratio may be
        altered.

    --resampleWidth pixelsW
        Resample image to specified width.

    --resampleHeight pixelsH
        Resample image to specified height.

    -Z pixelsWH
    --resampleHeightWidthMax pixelsWH
        Resample image so height and width aren't greater than specified
        size.

### xib 跟 controller 关联，执行到初始化时候发生错误

解决方法：重新创建一个controller并同时创建xib，观察发现

    点击`File's Owner`时候，有一个`view - View`的`Outlet`

    点击`View`的时候，有一个`view - File's Owner`的`Outlet`

### ib 使用技巧 [摘自《代码手写UI，xib和StoryBoard间的博弈，以及Interface Builder的一些小技巧》](https://onevcat.com/2013/12/code-vs-xib-vs-storyboard/)

#### 同时添加多个outlet

在IB中，选中一个view并右键点击，将会出现灰色的HUD，可以在其上方便地拖拉或设定事件和outlet。
你可以同时打开多个这样的面板来一次性添加所有outlet。右键点击面板，**随便拖动一下面板，然后再打开另一个。**
你会发现前一个面板也留下来了，这样你就可以方便地进行拖拽设定了。

#### 可视化坐标距离

选中一个组件，然后按住`option键`并将鼠标移动到其他组件上试试

#### 在一组view层次中进行选择

按住`Cmd`和`Shift`，然后在需要选择的`view`上方按右键，就可以列出在点击位置上所有的`view`的列表。藉此就
可以方便快速地选中想要的`view`了。

#### 添加辅助线

在左边的层级列表中双击某个view，然后`Cmd+_`或者`Cmd+|`即可在选中的view上添加一条水平或者垂直中心的辅助线。

### Storyboard 中实现组件复用

在Storyboard中，可以创建自定义的ViewController，在自定义的ViewController中，添加并实现自定义的组件，
ViewController最好只包含该组件，这样当需要调用该组件时，通过viewcontroller的id获得该控制器：

```swift
let storyBoard = UIStoryboard(name: "ServiceStoryboard", bundle: nil)
let vc = storyBoard.instantiateViewController(withIdentifier: "servicePage")
```

然后通过vc.view即可获得自定义的组件。对于简单的自定义组件，用代码实现会更方便些。

### 动态添加约束

```swift
let constraint = NSLayoutConstraint(
    // view1
    item: view1,
    attribute: NSLayoutAttribute.Trailing,
    relatedBy: NSLayoutRelation.Equal,
    // view2
    toItem: view2,
    attribute: NSLayoutAttribute.Trailing,

    multiplier: 1,
    constant: 10
)

someView.addConstraint(constraint)
// view1.att1 (related = <= >=) view2.attr * multiplier + constant
// 注意，当不需要第二个属性（toItem 为 nil）的时候，应该设置为 .NotAnAttribute，否则会报错
```

### 随机数

```swift
let MAX = 10
Int(arc4random() % MAX)
```

### [Xcode Indexing 的 bug](http://stackoverflow.com/questions/24782721/xcode-swift-indexing-forever)

```swift
// 这样写可能会导致 Xcode indexing 假死
struct Objects {
    let objectA = [
        "text1",
        "text2",
        "text3",
        "text4"
    ]
}

// 需要改成这样
struct Objects {
    let objectA = [ "text1",  "text2",  "text3",  "text4"]
}

// 简直无语
```

### `view`无法居中可能是缺少`height`或者`width`约束，也可能因此无法点击

### 扩展File's Owner 的 Attributes 面板 @IBDesignable @IBInspectable

```swift
@IBDesignable
class IconButtonViewController: UIViewController {
    这样在File's Owner Attribute面板中就会增加一个Test属性
    @IBInspectable var test:String
}
```

### 导入`Pods`库的步骤

1. 在`Podfiles`加入需要引入的库，比如：`pod 'RxSwift', '~> 2.3'`
2. 选择工程的 `Target` -> `Build Settings` 菜单 -> 搜索 `header`, 找到`User Header Search Paths`
3. 添加`$(PODS_ROOT)`，并选择`recursive`


### 遍历数组

`for (i, cell) in cells.enumerate() { /* ... */ }`

### iOS 手势识别 - gestureRecognizer

    http://blog.csdn.net/sirchenhua/article/details/7296230

向左向右轻划

```objective-c
UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self
                                                action:@selector(handleSwipeLeft)];
swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
[self.view addGestureRecognizer:swipeLeft];
[swipeLeft release];

UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self
                                                 action:@selector(handleSwipeRight)];
swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
[self.view addGestureRecognizer:swipeRight];
[swipeRight release];
```

单指单击

```objective-c
UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                                    action:@selector(handleSingleFingerEvent:)];
singleFingerOne.numberOfTouchesRequired = 1; //手指数
singleFingerOne.numberOfTapsRequired = 1; //tap次数
singleFingerOne.delegate = self;
[self.view addGestureRecognizer:singleFingerOne];
```

单指双击

```objective-c
UITapGestureRecognizer *singleFingerTwo = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                                    action:@selector(handleSingleFingerEvent:)];
singleFingerTwo.numberOfTouchesRequired = 1;
singleFingerTwo.numberOfTapsRequired = 2;
singleFingerTwo.delegate = self;
[self.view addGestureRecognizer:singleFingerTwo];
```

双指单击和双击
```objective-c
UITapGestureRecognizer *doubleFingerOne = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                                    action:@selector(handleDoubleFingerEvent:)];
doubleFingerOne.numberOfTouchesRequired = 2;
doubleFingerOne.numberOfTapsRequired = 1;
doubleFingerOne.delegate = self;

UITapGestureRecognizer *doubleFingerTwo = [[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                                    action:@selector(handleDoubleFingerEvent:)];
doubleFingerTwo.numberOfTouchesRequired = 2;
doubleFingerTwo.numberOfTapsRequired = 2;
doubleFingerTwo.delegate = self;

[self.view addGestureRecognizer:doubleFingerOne];
[self.view addGestureRecognizer:doubleFingerTwo];

//如果不加下面的话，当单指双击时，会先调用单指单击中的处理，再调用单指双击中的处理
[singleFingerOne requireGestureRecognizerToFail:singleFingerTwo];
//同理双指亦是如此
[doubleFingerOne requireGestureRecognizerToFail:doubleFingerTwo];
```

事件处理方法：

```objective-c
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
        //单指单击
        NSLog(@"单指单击");
    }else if(sender.numberOfTapsRequired == 2){
        //单指双击
        NSLog(@"单指双击");
     }
 }
 //处理双指事件
- (void)handleDoubleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
         //双指单击
         NSLog(@"双指单击");
     }else if(sender.numberOfTapsRequired == 2){
         //双指双击
         NSLog(@"双指双击");
     }
}
```

### UIImageView addGestureRecognizer 失败

`imageView.userInteractionEnabled = true`


### ViewController 生命周期

    http://blog.csdn.net/qijianli/article/details/7826979/

init -> loadView -> viewDidLoad -> viewWillAppear -> viewDidAppear -> viewWillDisappear -> viewDidDisppear -> viewDidUnload -> dealloc

viewDidUnload -> loadView

viewDidDisappear -> viewWillAppear


### 使用各种 ViewController 的时候，不要私自 addSubview 到当前 view，应该用 presentViewController 方法

`controller.presentViewController(viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)`

### 异步调用方法

```swift
// 第二个参数是纳秒，10e-9秒
let time = dispatch_time(DISPATCH_TIME_NOW, Int64(5e8))
dispatch_after(time, dispatch_get_global_queue(0, 0)) { () -> Void in
    self.scrollView.contentSize = {
        let height = self.middleContainer.frame.size.height + self.imageView.frame.size.height
        let size = CGSize(width: self.view.frame.size.width, height: height)
        return size
    }()
}
```

### [增加了scrollView之后手势失效](http://www.jianshu.com/p/c041398fcd6d)

```swift
func makeGestureAvailable(){
    if let gestureArray = self.navigationController?.view.gestureRecognizers {  // 这里的view换成自己的view
        gestureArray.forEach({ (gesture) in
            if gesture.isKindOfClass(UIScreenEdgePanGestureRecognizer) {
                self.scrollView.panGestureRecognizer.requireGestureRecognizerToFail(gesture)
            }
        })
    }
}
```

### git 设置socks代理

```bash
git config --global https.proxy 'socks5://127.0.0.1:1080'
git config --global http.proxy 'socks5://127.0.0.1:1080'
```

### String.Index

```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index] // 注意使用方式
// a
```

### String 转换成 HexString

```swift
func toHexString(int: Int) -> String{
    let highHex = int / 16 % 16
    let lowHex = int % 16
    let charList = "0123456789ABCDEF"
    let highIndex = charList.index(charList.startIndex, offsetBy: highHex)
    let lowIndex = charList.index(charList.startIndex, offsetBy: lowHex)
    return "\(charList[highIndex])\(charList[lowIndex])"
}
```

### String 和 Data 互换

```swift
"hello".data(using: String.Encoding.isoLatin1, allowLossyConversion: false) // 这个false是什么？
String(data: Data([0x68, 0x65, 0x6C, 0x6C 0x6F]), encoding: String.Encoding.isoLatin1)
```


### 'SocketRocket/SRWebSocket.h' file not found with <angled> include; use "quotes" instead

在`header search path`中加入对应的目录即可，比如`$(PODS_ROOT)/**`


### Apple Mach-O Linker Error ld: framework XXX not found

尝试了各种方法都没效果后，可以试试把依赖的目录复制到项目中


### Reading data: The file “Info.plist” couldn’t be opened because there is no such file.

`Target -> Build Phases -> Copy Bundle Resources`
Remove all incorrect referrences in the list


### 腾讯信鸽推送

使用测试模式可以发送，非测试模式提示“无效帐号，请检查后重试”

好像是腾讯的bug？只能用测试预览模式发送，不能点击正常推送


1. 重装app，device_token会重新生成
2. 在应用中的时候不会收到通知
3. 用户拒绝接受通知不会产生device_token
4. 在系统设置中允许了就会触发产生device_token

**非常重要：environment参数ios必选，2表示开发环境**


如何获得token？

```swift
// AppDelegate
func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    // deviceToken 转字符串
    let token:String = deviceToken.map { String(format: "%02x", $0) }.joined().uppercased()
    print("token==\(token)")
}

func registerNofitication() {
    UIApplication.shared.registerForRemoteNotifications()
}

func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
    self.registerNofitication()
}
```

```javascript
// APN 发送一个gogogo的alert通知
{"aps":{"alert":"gogogo"}}
```

更多资料参考：http://developer.qq.com/wiki/xg/%E6%9C%8D%E5%8A%A1%E7%AB%AFAPI%E6%8E%A5%E5%85%A5/Rest%20API%20%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97/Rest%20API%20%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97.html

配合postman使用的js脚本

```javascript
/* 
POST /v2/push/single_device? HTTP/1.1
Host: openapi.xg.qq.com

device_token=965BD3A434D52F49A80666D4C5471C9923187A0A2472FC4E2FE4D6C1DEA83FAF&message_type=1&message=hello%20test&expire_time=0

*/
(function() {
    function getKOSortedAndJoinOf(para) {
        return para.split('&').map(p=>decodeURI(p)).sort().join('')
    }
    function joinStr({method, url, query, secretKey}) {
        return method.toUpperCase() + url.replace(/.*?https?:\/\/|\?.*$/g, '') + getKOSortedAndJoinOf(query) + secretKey
    }
    function caculateMD5(joinedStr) {
        return CryptoJS.MD5(joinedStr).toString()
    }
    var method = 'POST'
      , url = document.querySelector('#url').value
      , orgParam = pm.request.body.getData(true)
      , secretKey = '三十二位'
      , accessId = '十位阿拉伯数字？'
      , timeStamp = parseInt(+new Date() / 1000)
      , query = orgParam.replace(/&access_id.*$/, '') + '&access_id=' + accessId + '&timestamp=' + timeStamp
      , sign = caculateMD5(joinStr({
          method,
          url,
          query,
          secretKey
        }))
    pm.request.body.codeMirror.setValue(query + '&sign=' + sign)

    var testInfo = {
        method: 'POST',
        url: 'http://openapi.xg.qq.com/v2/push/single_device',
        //有四个参数，
        query: 'access_id=123&timestamp=1386691200&Param1=Value1&Param2=Value2',
        secretKey: 'abcde'
    }
    // 检测 sign 的有效性
    var expectedStr = 'POSTopenapi.xg.qq.com/v2/push/single_deviceParam1=Value1Param2=Value2access_id=123timestamp=1386691200abcde'
    var expectedMD5 = 'ccafecaef6be07493cfe75ebc43b7d53'
    console.log(`${joinStr(testInfo)}\n${expectedStr}\n${caculateMD5(joinStr(testInfo))}\n${expectedMD5}`)
})()
```