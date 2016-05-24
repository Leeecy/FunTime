//
//  WTNSportTitleView.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTNSportTitleView;
@protocol WTNTitleViewDelegate <NSObject>

@optional
-(void)titleView:(WTNSportTitleView*)titleView scrollToIndex:(NSInteger)tagIndex;

@end

@interface WTNSportTitleView : UIView
@property (nonatomic,weak) id<WTNTitleViewDelegate>delegate;

-(void)wanerSelected:(NSInteger)tagIndex;
@end
