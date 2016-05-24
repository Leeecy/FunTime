//
//  WTNMovieResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNMovieListModel.h"
@interface WTNMovieResultModel : JSONModel
@property (nonatomic, strong)NSArray<WTNMovieListModel> * resultArr;
@end
