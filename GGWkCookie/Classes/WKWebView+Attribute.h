//
//  WKWebView+Attribute.h
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/17.
//

#import <WebKit/WebKit.h>

@protocol GGWkWebViewDelegate <NSObject>

/// 获取传入cookie的字典
- (NSDictionary *)webviewSetAppCookieKeyAndValue;

@end

@interface WKWebView (Attribute)

/// cookie代理
@property (nonatomic, weak) id<GGWkWebViewDelegate> cookieDelegate;

/// 自定义 cookie 值
@property (nonatomic, strong) NSDictionary *cookieKeyValue;

@end
