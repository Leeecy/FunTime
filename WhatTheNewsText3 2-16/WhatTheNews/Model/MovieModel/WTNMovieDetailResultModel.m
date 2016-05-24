//
//  WTNMovieDetailResultModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieDetailResultModel.h"

@implementation WTNMovieDetailResultModel
+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"data":@"movieData",@"videos":@"videosArr"}];
}

@end
