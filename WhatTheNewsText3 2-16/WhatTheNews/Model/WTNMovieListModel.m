//
//  WTNMovieListModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieListModel.h"

@implementation WTNMovieListModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"list":@"listArr"}];
}

@end
