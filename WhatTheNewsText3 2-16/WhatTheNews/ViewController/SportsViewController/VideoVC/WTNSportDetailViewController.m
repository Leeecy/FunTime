//
//  WTNSportDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/7.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNSportDetailViewController.h"
#import "WTNRootVideoModel.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"
@interface WTNSportDetailViewController ()<WKNavigationDelegate>{
    WKWebView *_webView;
}

@end

@implementation WTNSportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 60)];
    view.backgroundColor = HGColor(73, 152, 231);
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://daily.zhihu.com/story/%@",self.sportModel.id]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError *  connectionError) {
//        NSString * htmlString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        // 深拷贝
//        NSMutableString * string = [htmlString mutableCopy];
//        WTNLog(@"string==%@",string);
        //删掉网页不需要的文字 button
//        NSRange range = [string rangeOfString:@"class=\"bottom-recommend-download-link\" href=\"/download\""];
//        NSRange range1 = [string rangeOfString:@"class=\"bottom-recommend-download-link\""];
//        NSRange range2 = [string rangeOfString:@"href=\"/download\""];
        
    //    NSRange range3 = [string rangeOfString:@"class=\"header-for-mobile-btn\""];
//        NSRange range4 = [string rangeOfString:@"class=\"header-for-mobile-logo-img\""];
//        NSRange range5 = [string rangeOfString:@"class=\"header-for-mobile-meta\""];
//        NSRange range7 = [string rangeOfString:@"href=\"/download\" class=\"header-for-mobile-download-link\""];
       // [string replaceCharactersInRange:range withString:@""];
       // [string replaceCharactersInRange:range1 withString:@""];
      //  [string replaceCharactersInRange:range2 withString:@""];
      // [string replaceCharactersInRange:range3 withString:@""];
//        [string replaceCharactersInRange:range4 withString:@""];
//        [string replaceCharactersInRange:range5 withString:@""];
//        [string replaceCharactersInRange:range7 withString:@""];
       // [_webView loadHTMLString:string baseURL:url];
  //  }];
    [_webView loadRequest:request];
     _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [self.view addSubview:view];
    
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //打开HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //显示的文字
    hud.labelText = @"正在加载...";
}
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    //关闭HUD
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//}
// 当内容开始返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    //关闭HUD
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//隐藏HUD窗口后调用
-(void)hudWasHidden:(MBProgressHUD *)hud{
    [hud removeFromSuperview];
    hud = nil;
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
