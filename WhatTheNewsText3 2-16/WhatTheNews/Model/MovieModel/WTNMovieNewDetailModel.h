//
//  WTNMovieNewDetailModel.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNFilmListDetail.h"
@interface WTNMovieNewDetailModel : JSONModel
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *timeNow;
@property (nonatomic, strong)NSArray<WTNFilmListDetail> * filmList;
@end
