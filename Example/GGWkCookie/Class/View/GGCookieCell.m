//
//  GGCookieCell.m
//  GGWkCookie_Example
//
//  Created by GarrettGao on 2018/9/17.
//  Copyright © 2018年 gaoguohao. All rights reserved.
//

#import "GGCookieCell.h"



@implementation GGCookieCell

+ (GGCookieCell *)loadXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)setContent:(NSString *)content {
    UILabel *label = [self viewWithTag:101];
    label.text = content;
}

@end
