//
//  GGCookiesViewController.m
//  GGWkCookie_Example
//
//  Created by GarrettGao on 2018/9/17.
//  Copyright © 2018年 gaoguohao. All rights reserved.
//

#import "GGCookiesViewController.h"
#import "GGCookieCell.h"
#import "GGAddCookieCell.h"


@interface GGCookiesViewController ()<UITableViewDelegate,UITableViewDataSource, GGAddCookieCellDelegate> {
    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation GGCookiesViewController

- (void)viewDidLoad {
    self.title = @"App自定义Cookie";
    [super viewDidLoad];
}

#pragma mark - Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cookieDic.allKeys.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _cookieDic.allKeys.count) {
        GGAddCookieCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GGAddCookieCell"];
        if (!cell) { cell = [GGAddCookieCell loadXib]; }
        cell.delegate = self;
        return cell;
    }
    
    NSString *cookieName = [_cookieDic.allKeys objectAtIndex:indexPath.row];
    NSString *cookieValue = [_cookieDic objectForKey:cookieName];
    NSString *content = [NSString stringWithFormat:@"%ld.\n name = %@\n value = %@",
                         (long)indexPath.row + 1,cookieName,cookieValue];
    
    GGCookieCell * cell = [tableView dequeueReusableCellWithIdentifier:@"GGCookieCell"];
    if (!cell) { cell = [GGCookieCell loadXib]; }
    cell.content = content;
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *key = [_cookieDic.allKeys objectAtIndex:indexPath.row];
        [_cookieDic removeObjectForKey:key];
    }
    [tableView reloadData];
    
}

#pragma mark - GGAddCookieCellDelegate
- (void)addCookieWithName:(NSString *)name withValue:(NSString *)value {
    [_cookieDic setValue:value forKey:name];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
