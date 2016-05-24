//
//  WTNQRCodeViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNQRCodeViewController.h"
#import "WTNQRCodeDetailViewController.h"
@interface WTNQRCodeViewController (){
    
}

@end

@implementation WTNQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.scanLabel.layer.borderWidth = 1.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btnClicked:(id)sender{
    //扫描二维码
    WTNQRCodeDetailViewController *qrcodevc = [[WTNQRCodeDetailViewController alloc] init];
    qrcodevc.WTNQRCodeSuncessBlock = ^(WTNQRCodeDetailViewController *aqrvc,NSString *qrString){
        self.scanLabel.text = qrString;
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.WTNQRCodeFailBlock = ^(WTNQRCodeDetailViewController *aqrvc){
        self.scanLabel.text = @"fail~";
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.WTNQRCodeCancleBlock = ^(WTNQRCodeDetailViewController*aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
        self.scanLabel.text = @"扫描不到更多数据";
    };
    [self presentViewController:qrcodevc animated:YES completion:nil];
}

@end
