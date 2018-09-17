//
//  GGAddCookieCell.h
//  GGWkCookie_Example
//
//  Created by GarrettGao on 2018/9/17.
//  Copyright © 2018年 gaoguohao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GGAddCookieCellDelegate <NSObject>

- (void)addCookieWithName:(NSString *)name withValue:(NSString *)value;

@end

@interface GGAddCookieCell : UITableViewCell

@property (nonatomic, weak)  id<GGAddCookieCellDelegate> delegate;

+ (GGAddCookieCell *)loadXib;

@end
