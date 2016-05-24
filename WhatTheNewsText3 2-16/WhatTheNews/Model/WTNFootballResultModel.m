//
//  WTNFootballResultModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNFootballResultModel.h"

@implementation WTNFootballResultModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"toplist":@"toplistArr"}];
}

@end
