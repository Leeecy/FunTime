//
//  WTNSportVideoResultModel.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNSportVideoResultModel.h"

@implementation WTNSportVideoResultModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"appDescription"}];
}
@end
