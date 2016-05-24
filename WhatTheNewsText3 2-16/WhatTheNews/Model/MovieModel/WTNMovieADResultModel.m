//
//  WTNMovieADResultModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/31.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieADResultModel.h"

@implementation WTNMovieADResultModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"filmList":@"filmList"}];
}
@end
