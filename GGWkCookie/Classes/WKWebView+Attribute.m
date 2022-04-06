//
//  WKWebView+Attribute.m
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/17.
//

#import "WKWebView+Attribute.h"
#import <objc/runtime.h>

@interface WeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id object;
@end

@implementation WeakObjectContainer
- (instancetype) initWithObject:(id)object
{
    if (!(self = [super init])) {return nil;}
    _object = object;
    return self;
}

@end

@implementation WKWebView (Attribute)

static NSString *delegatePointer;

- (void)setCookieDelegate:(id<GGWkWebViewDelegate>)cookieDelegate {
    objc_setAssociatedObject(self, &delegatePointer, [[WeakObjectContainer alloc] initWithObject:cookieDelegate],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<GGWkWebViewDelegate>)cookieDelegate {
    WeakObjectContainer *container = objc_getAssociatedObject(self, &delegatePointer);
    return container.object;
}


static NSString *cookieKeyValuePointer;

- (void)setCookieKeyValue:(NSDictionary *)cookieKeyValue {
    objc_setAssociatedObject(self, &cookieKeyValuePointer, cookieKeyValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)cookieKeyValue {
    return objc_getAssociatedObject(self, &cookieKeyValuePointer);
}

@end
