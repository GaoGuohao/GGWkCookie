//
//  GGViewController.m
//  GGWkCookie
//
//  Created by gaoguohao on 09/14/2018.
//  Copyright (c) 2018 gaoguohao. All rights reserved.
//

#import "GGViewController.h"
#import "GGCookiesViewController.h"
//#import <GGWkCookie/GGWkCookie.h>
#import "GGWkCookie.h"


@interface GGViewController ()<WKUIDelegate,WKNavigationDelegate,GGWkWebViewDelegate>
{
    NSMutableDictionary *_cookieDic;
}
@end

@implementation GGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Cookie自定义";
    
   
    // 设置一个测试cookie的字典
    _cookieDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                 @"11111": @"GarrettGao",
                                                                 @"22222": @"GGWkCookie",
                                                                 }];
    
    [self initWebView];
}


- (void)initWebView {
    
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences* preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    WKWebView* webView = [[WKWebView alloc] initWithFrame:CGRectZero
                                            configuration:configuration];
    webView.tag = 101;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    webView.cookieDelegate = self;  //设置cookie代理
    
    [self.view addSubview:webView];
    
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    [webView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [webView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [webView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
    // 开启自定义cookie
    [webView startCustomCookie];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.title = @"加载中...";
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    self.title = @"";
    [webView evaluateJavaScript:@"document.cookie" completionHandler:^(NSString *result, NSError * _Nullable error) {
        NSLog(@"网页中的cookie为：\n%@",[result componentsSeparatedByString:@"; "]);
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.title = @"";
    NSLog(@"%@", error);
}

#pragma mark - GGWkWebViewDelegate
/// 代理方法中设置 app自定义的cookie
- (NSDictionary *)webviewSetAppCookieKeyAndValue {
    return _cookieDic;
}

#pragma mark - OnClicked

// 刷新
- (IBAction)onReloadClicked:(UIBarButtonItem *)sender {
    WKWebView *webview = [self.view viewWithTag:101];
    [webview reloadCookie];
    [webview reload];
}

// 操作
- (IBAction)onMakeCookieClicked:(UIBarButtonItem *)sender {
    
    GGCookiesViewController *viewController = [[GGCookiesViewController alloc] init];
    viewController.cookieDic = _cookieDic;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
