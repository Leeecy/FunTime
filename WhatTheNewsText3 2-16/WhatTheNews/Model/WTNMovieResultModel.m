//
//  WTNMovieResultModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieResultModel.h"

@implementation WTNMovieResultModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"result":@"resultArr"}];
}
@end
