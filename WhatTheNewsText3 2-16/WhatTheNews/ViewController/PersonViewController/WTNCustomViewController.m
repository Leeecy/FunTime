//
//  WTNCustomViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNCustomViewController.h"

@interface WTNCustomViewController ()

@end

@implementation WTNCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-30*2, SCREEN_HEIGHT-50*2)];
    self.view.backgroundColor = HGColor(237, 237, 237);
    label.text = @"WhatTheNews：一款非常有趣的软件，它的功能在于能够让你利用iPhone手机来阅读了解最新资讯和体育。\n\n关注我们,关注一种生活态。\n\n新浪微博:@Awful__blow\n\nQQ邮箱:347979248@qq.com \n\n技术网址:http://blog.csdn.net/chenl22";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
}


@end
