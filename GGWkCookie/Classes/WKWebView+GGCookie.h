//
//  WKWebView+GGCookie.h
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/14.
//

#import <WebKit/WebKit.h>


@interface WKWebView (GGCookie)


/// 开启自定义cookie，此方法需要放到 loadRequest之前
- (void)startCustomCookie;

/**
 刷新 cookie 设置
 代理方法： - (NSDictionary *)webviewGetCookieKeyValue 会重新回调
 */
- (void)reloadCookie;

@end
