//
//  WTNDrawerViewController.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTNDrawerViewController : UIViewController
-(void)clickDrawerButton;
@property (nonatomic, assign) BOOL isDrawOpen; //侧滑窗是否关闭(关闭时显示为主页)

@end
