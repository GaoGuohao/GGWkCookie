//
//  WKWebView+Swizzling.m
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/14.
//

#import "WKWebView+Swizzling.h"
#import "WKWebView+Attribute.h"
#import <objc/runtime.h>

@implementation WKWebView (Swizzling)

+ (void)load {
    
    // 交换系统的 reload方法 处理请求头中的cookie
    Method o_mt_reload = class_getInstanceMethod([self class], @selector(loadRequest:));
    Method n_mt_reload = class_getInstanceMethod([self class], @selector(e_loadRequest:));
    method_exchangeImplementations(o_mt_reload, n_mt_reload);
}

/// 拦截 系统的 loadRequest方法，插入我们自定义的cookie到请求头中
- (nullable WKNavigation *)e_loadRequest:(NSURLRequest *)request {
    
    NSMutableURLRequest *newRequeset = [request mutableCopy];
    
    if([self.cookieKeyValue isKindOfClass:[NSDictionary class]] ||
       [self.cookieKeyValue isKindOfClass:[NSMutableDictionary class]]){
        
        NSString *cookie = [request valueForHTTPHeaderField:@"Cookie"];
        if (!cookie || [cookie isKindOfClass:[NSNull class]]) {
            cookie = @"";
        }
        for (NSString *key in self.cookieKeyValue.allKeys) {
            NSString *keyValue = [NSString stringWithFormat:@"%@=%@;",key,[self.cookieKeyValue objectForKey:key]];
            cookie = [cookie stringByAppendingString:keyValue];
        }
        [newRequeset setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    
    return [self e_loadRequest:newRequeset];
}
@end
