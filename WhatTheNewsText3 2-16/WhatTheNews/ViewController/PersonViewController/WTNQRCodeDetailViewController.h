//
//  WTNQRCodeDetailViewController.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/7.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTNQRCodeDetailViewController : UIViewController
@property (nonatomic, copy) void (^WTNQRCodeCancleBlock) (WTNQRCodeDetailViewController *);//扫描取消
@property (nonatomic, copy) void (^WTNQRCodeSuncessBlock) (WTNQRCodeDetailViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^WTNQRCodeFailBlock) (WTNQRCodeDetailViewController *);//扫描失败
@end
