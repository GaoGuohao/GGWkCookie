//
//  WKWebView+GGCookie.m
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/14.
//

#import "WKWebView+GGCookie.h"
#import "GGWkBundelManager.h"
#import "WKWebView+Attribute.h"

@implementation WKWebView (GGCookie)

#define kJhuCookieJsCodeTag @"// 这是一个代码片段标示，用于删除某个WKUserScript代码片段的标记"

- (void)startCustomCookie {
    [self addAppJsCode];
    [self reloadCookie];
}

/**
 设置 App 基本支持的JS代码
 */
- (void)addAppJsCode {

    NSString *jsCode = [GGWkBundelManager loadJsCodeWithFileName:@"GGCookie" withType:@"js"];
    if (jsCode) {
        WKUserScript *cookieInScript = [[WKUserScript alloc]
                                        initWithSource:jsCode
                                        injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                        forMainFrameOnly:NO];
        [self.configuration.userContentController addUserScript:cookieInScript];
    }
}

/**
 刷新设置cookie
 */
- (void)reloadCookie {
    
    // 删除所有自定义cookie
    [self removeAllTagCookie];
    
    // 代理获取最新的cookie值
    if (self.cookieDelegate && [self.cookieDelegate respondsToSelector:@selector(webviewSetAppCookieKeyAndValue)]) {
        self.cookieKeyValue = [self.cookieDelegate webviewSetAppCookieKeyAndValue];
    }
    
    //重新添加cookie
    if (self.cookieKeyValue) {
        for (NSString *name in self.cookieKeyValue.allKeys) {
            [self addCookieWithKey:name withValue:[self.cookieKeyValue objectForKey:name]];
        }
    }
}


/**
 添加某个cookie
 */
- (void)addCookieWithKey:(NSString *)key withValue:(NSString *)value {
    
    NSString *jsCode = [NSString stringWithFormat:@"app_setCookie('%@','%@')",key,value];
    [self evaluateJavaScript:jsCode completionHandler:nil];
    
    // 代码片段标签
    NSString *tag = [self getCustomJsCodeTagWithKey:key];
    
    // 先删除原来的代码片段
    [self deleteUserSciptWithTag:tag];
    
    // 再添加新的
    [self addUserScriptWithJsCode:jsCode WithTag:tag];
}

/**
 删除某个cookie
 */
- (void)removeCookieWithKey:(NSString *)key {
    
    // 删除浏览器的某个cookie
    NSString *jsCode = [NSString stringWithFormat:@"app_deleteCookie('%@')",key];
    [self evaluateJavaScript:jsCode completionHandler:nil];
    
    // 删除添加cookie的脚本代码
    NSString *tag = [self getCustomJsCodeTagWithKey:key];
    [self deleteUserSciptWithTag:tag];
}

/**
 删除所有的标签（app自定义）cookie
 */
- (void)removeAllTagCookie {
    
    // 删除所有的cookie
    if (self.cookieKeyValue) {
        for (NSString *key in self.cookieKeyValue.allKeys) {
            NSString *jsCode = [NSString stringWithFormat:@"app_deleteCookie('%@')",key];
            [self evaluateJavaScript:jsCode completionHandler:nil];
        }
    }
    
    // 删除所有的本地自定义js 设置cookie的脚本
    [self deleteUserSciptWithTag:[self getCustomJsCodeTagWithKey:nil]];
    
    // 属性置空
    self.cookieKeyValue = @{};
}


/**
 添加某个代码片段
 
 @param jsCode 插入的js代码
 @param tag tag 片段标示
 */
- (void)addUserScriptWithJsCode:(NSString *)jsCode WithTag:(NSString *)tag {
    
    if (jsCode) {
        WKUserScript *cookieInScript = [[WKUserScript alloc] initWithSource:[NSString stringWithFormat:@"%@ \n%@",jsCode,tag]
                                                              injectionTime:WKUserScriptInjectionTimeAtDocumentStart
                                                           forMainFrameOnly:NO];
        [self.configuration.userContentController addUserScript:cookieInScript];
    }
}

/**
 删除某个代码片段
 
 @param tag 片段标示, （敲黑板）注意：当 tag == 宏定义 kJhuCookieJsCodeTag时，将删除所有的自定义cookie
 */
- (void)deleteUserSciptWithTag:(NSString *)tag {
    
    if (tag) {
        WKUserContentController *userContentController = self.configuration.userContentController;
        NSMutableArray<WKUserScript *> *array = [userContentController.userScripts mutableCopy];
        int i = 0;
        BOOL isHave = NO;
        for (WKUserScript* wkUScript in userContentController.userScripts) {
            if ([wkUScript.source containsString:tag]) {
                [array removeObjectAtIndex:i];
                isHave = YES;
                continue;
            }
            i ++;
        }
        
        // 如果原来的代码片段中存在
        if (isHave) {
            ///没法修改数组 只能移除全部 再重新添加
            [userContentController removeAllUserScripts];
            for (WKUserScript* wkUScript in array) {
                [userContentController addUserScript:wkUScript];
            }
        }
    }
}

/**
 自定义js脚本片段的一个标示，用于删除某段代码片段
 
 @param key cookie name
 @return 拼接后的代码片段标示
 */
- (NSString *)getCustomJsCodeTagWithKey:(NSString *)key {
    if (!key) key = @"";
    return [kJhuCookieJsCodeTag stringByAppendingString:key];
}

@end
