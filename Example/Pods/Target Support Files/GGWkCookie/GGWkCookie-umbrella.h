#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GGWkBundelManager.h"
#import "GGWkCookie.h"
#import "WKWebView+Attribute.h"
#import "WKWebView+GGCookie.h"
#import "WKWebView+Swizzling.h"

FOUNDATION_EXPORT double GGWkCookieVersionNumber;
FOUNDATION_EXPORT const unsigned char GGWkCookieVersionString[];

