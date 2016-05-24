//
//  WTNMovieNewsModel.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNFilmNewsListModel.h"
@interface WTNMovieNewsModel : JSONModel;
@property (nonatomic, copy) NSString *cinemaCount;
@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *filmCount;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, strong)NSArray<WTNFilmNewsListModel> * filmList;

@end
