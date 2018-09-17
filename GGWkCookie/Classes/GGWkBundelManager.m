//
//  GGWkBundelManager.m
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/14.
//

#import "GGWkBundelManager.h"

#define GG_BUNDLE_FRAMEWORK_NAME_WK @"Frameworks/GGWkCookie.framework/GGWkCookie.bundle"
#define GG_BUNDLE_LIB_NAME_WK @"GGWkCookie.bundle"

@implementation GGWkBundelManager

/**
 读取本地js文件
 
 @param name 文件名称
 @param type 文件类型
 @return 返回js代码
 */
+ (NSString *)loadJsCodeWithFileName:(NSString *)name withType:(NSString *)type {
    
    NSString *filePath = [[self mainBundleWithPath:GG_BUNDLE_FRAMEWORK_NAME_WK] pathForResource:name ofType:type];
    NSString *jsCode = [NSString stringWithContentsOfFile:filePath
                                     encoding:NSUTF8StringEncoding
                                        error:nil];
    if (!jsCode) {
        filePath = [[self mainBundleWithPath:GG_BUNDLE_LIB_NAME_WK] pathForResource:name ofType:type];
        jsCode = [NSString stringWithContentsOfFile:filePath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    }
    return jsCode;
}

/// 当前组件的Bundle
+ (NSBundle *)mainBundleWithPath:(NSString *)path {
    NSString *bundelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: path];
    return [NSBundle bundleWithPath: bundelPath];
}

@end
