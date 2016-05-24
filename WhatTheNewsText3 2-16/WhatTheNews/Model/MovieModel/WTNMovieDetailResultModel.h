//
//  WTNMovieDetailResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNMovieDataModel.h"
#import "WTNMovieVideoModel.h"
@interface WTNMovieDetailResultModel : JSONModel
@property (nonatomic, strong)WTNMovieDataModel * movieData;
@property (nonatomic, strong)NSArray<WTNMovieVideoModel> * videosArr;
@end
