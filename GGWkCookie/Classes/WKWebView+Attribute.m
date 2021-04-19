//
//  WKWebView+Attribute.m
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/17.
//

#import "WKWebView+Attribute.h"
#import <objc/runtime.h>

@implementation WKWebView (Attribute)

static NSString *delegatePointer;

- (void)setCookieDelegate:(id<GGWkWebViewDelegate>)cookieDelegate {
    objc_setAssociatedObject(self, &delegatePointer, cookieDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<GGWkWebViewDelegate>)cookieDelegate {
    return objc_getAssociatedObject(self, &delegatePointer);
}


static NSString *cookieKeyValuePointer;

- (void)setCookieKeyValue:(NSDictionary *)cookieKeyValue {
    objc_setAssociatedObject(self, &cookieKeyValuePointer, cookieKeyValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)cookieKeyValue {
    return objc_getAssociatedObject(self, &cookieKeyValuePointer);
}

@end
