# Tips about iOS dev

## FAQ

### **Q:** Pod install, The dependency \`*****\` is not used in any concrete target

http://stackoverflow.com/questions/40234810/pod-install-the-dependency-is-not-used-in-any-concrete-target

**A:** Your `Podfile` should contain in which target you want to install the cocoapods. The post installer in your Podfile setting only `ACTIVE_ARCH` flag to `NO` in each target.

If you have more than 20 targets in your app, maybe try to remove `Podfile` and `Podfile.lock` and do `pod init` then CococaPods gem create a valid `Podfile` for your app. Then paste the cocoapods that your app using and paste the post installer instruction to the new Podfile and try to resinstall cocoapods using `pod install`

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

`Your Podfile has had smart quotes sanitised. To avoid issues in the future, you should not use TextEdit for editing it. If you are not using TextEdit, you should turn off smart quotes in your editor of choice.`

----

### **Q:** ld: warning: directory not found for option

http://stackoverflow.com/questions/9458739/ld-warning-directory-not-found-for-option

**A:**
**You need to do this:**

1.  Click on your project (targets)
2.  Click on **Build Settings**
3.  Under **Library Search Paths**, delete the paths

And regarding the second error, sorry i can't help you out with that one. Hope someone else can help you out.

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

> Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'unable to dequeue a cell with identifier Cell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard


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