//
//  UIView+WTNCL.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WTNCL)
//对于需要兼容64位机器的程序而言，需要用CGFloat
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign,nonatomic) CGFloat centerX;
@property (assign,nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@end
