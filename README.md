# GGWkCookie

[![CI Status](https://img.shields.io/travis/gaoguohao/GGWkCookie.svg?style=flat)](https://travis-ci.org/gaoguohao/GGWkCookie)
[![Version](https://img.shields.io/cocoapods/v/GGWkCookie.svg?style=flat)](https://cocoapods.org/pods/GGWkCookie)
[![License](https://img.shields.io/cocoapods/l/GGWkCookie.svg?style=flat)](https://cocoapods.org/pods/GGWkCookie)
[![Platform](https://img.shields.io/cocoapods/p/GGWkCookie.svg?style=flat)](https://cocoapods.org/pods/GGWkCookie)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
WKWebView管理cookie是很麻烦事，经常出现 App自定义cookie的值丢失 或 更新不及时 的情况。
通过长期踩坑，总结出WKWebview管理cookie的一种方案。

原理： WKWebview支持的插入脚本的方式，在每次页面渲染前，通过插入的Js脚本检测Cookie是否存在，如不存在，将cookie重新种入的思路。

注意：因为考虑避免子域名和根域名cookie重复出现，该方法所有的Cookie值将种在 根域名上。

## Installation

GGWkCookie is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GGWkCookie'
```

## Use
1.导入 引用头文件： 
```objc
#import "GGWkCookie.h"
```

2.实现 ```<GGWkWebViewDelegate>``` 协议 ，开启cookie开关 ```startCustomCookie()```:
```objc
 // 设置cookie代理
 webView.cookieDelegate = self;
 
 // 开启自定义cookie（在loadRequest前开启）
 [webView startCustomCookie];

/// 代理方法中设置 app自定义的cookie
- (NSDictionary *)webviewSetAppCookieKeyAndValue {

    return @{
             @"cookieName":@"value",
             };
}
```

3.如果代理中的cookie发生改变，调用 ```reloadCookie()``` 更新cookie,
```- (NSDictionary *)webviewSetAppCookieKeyAndValue```代理方法将获取最新的cookie值。

总结：
所以，我们只需要维护好 ```- (NSDictionary *)webviewSetAppCookieKeyAndValue```的代理方法，
在需要更新的时调用 ```reloadCookie()``` 方法即可。


## Author

gaoguohao, guohaoggh@163.com

## License

GGWkCookie is available under the MIT license. See the LICENSE file for more info.
