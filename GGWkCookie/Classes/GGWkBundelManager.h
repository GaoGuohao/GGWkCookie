//
//  GGWkBundelManager.h
//  GGWkCookie
//
//  Created by GarrettGao on 2018/9/14.
//

#import <Foundation/Foundation.h>

@interface GGWkBundelManager : NSObject

/**
 读取本地js文件
 
 @param name 文件名称
 @param type 文件类型
 @return 返回js代码
 */
+ (NSString *)loadJsCodeWithFileName:(NSString *)name withType:(NSString *)type;

@end
