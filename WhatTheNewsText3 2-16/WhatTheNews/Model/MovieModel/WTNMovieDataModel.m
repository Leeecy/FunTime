//
//  WTNMovieDataModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieDataModel.h"

@implementation WTNMovieDataModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"movieDataId"}];
}

@end
