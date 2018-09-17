//
//  GGAddCookieCell.m
//  GGWkCookie_Example
//
//  Created by GarrettGao on 2018/9/17.
//  Copyright © 2018年 gaoguohao. All rights reserved.
//

#import "GGAddCookieCell.h"
@interface GGAddCookieCell() {
    
    __weak IBOutlet UITextField *_nameTextField;
    __weak IBOutlet UITextField *_valueTextField;

}
@end

@implementation GGAddCookieCell

+ (GGAddCookieCell *)loadXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

#pragma mark - OnClicked

- (IBAction)onAddClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addCookieWithName:withValue:)]) {
        [self.delegate addCookieWithName:_nameTextField.text
                               withValue:_valueTextField.text];
    }
    _valueTextField.text = _nameTextField.text = @"";
}


@end
