//
//  WTNMovieADResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNFilmListModel.h"
@interface WTNMovieADResultModel : JSONModel
@property (nonatomic, copy) NSString *cinemaCount;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *filmCount;
@property (nonatomic, copy) NSString *cityId;
@property(nonatomic,strong)NSArray<WTNFilmListModel> * filmList;
@end
