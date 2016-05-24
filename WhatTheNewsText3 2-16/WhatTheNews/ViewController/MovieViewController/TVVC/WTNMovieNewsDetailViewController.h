//
//  WTNMovieNewsDetailViewController.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/6.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
//获取上个界面传值
@class  WTNFilmNewsListModel;
@class WTNFilmListDetail;
@interface WTNMovieNewsDetailViewController : UIViewController
@property(nonatomic,strong)WTNFilmNewsListModel *newsListModel;
@property(nonatomic,strong)WTNFilmListDetail *filmListDetail;
@end
