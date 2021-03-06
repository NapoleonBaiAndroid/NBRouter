//
//  NBWebViewController.m
//  NBRouter
//
//  Created by NapoleonBai on 2016/10/29.
//  Copyright © 2016年 BaiZhiqiang. All rights reserved.
//

#import "NBWebViewController.h"

#import "NBRouter.h"
#import <WebKit/WebKit.h>

@interface NBWebViewController ()

@property(nonatomic,strong)WKWebView *webView;

@end

@implementation NBWebViewController

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    printf("self===>>> %s",[[self.originUrl absoluteString] UTF8String]);
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:self.originUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
