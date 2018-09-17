//
//  GGCookieCell.h
//  GGWkCookie_Example
//
//  Created by GarrettGao on 2018/9/17.
//  Copyright © 2018年 gaoguohao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGCookieCell : UITableViewCell

@property (nonatomic, strong)  NSString *content;

+ (GGCookieCell *)loadXib;

@end
