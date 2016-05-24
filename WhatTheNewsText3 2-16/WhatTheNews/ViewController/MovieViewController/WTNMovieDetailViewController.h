//
//  WTNMovieDetailViewController.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WTNMovieDataModel;

@class WTNMovieVideoModel;
//接收上个界面Model传过来的model数据
@class WTNListModel;

@interface WTNMovieDetailViewController : UIViewController
@property(nonatomic,strong)WTNMovieDataModel *movieModel;
@property(nonatomic,strong)WTNMovieVideoModel *videoPlayUrl;
@property(nonatomic,strong)WTNListModel *listModel;
@end
