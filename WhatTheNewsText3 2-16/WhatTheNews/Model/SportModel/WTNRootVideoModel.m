//
//  WTNRootVideoModel.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNRootVideoModel.h"
@implementation WTNRootVideoModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"storyDescription"}];
}
@end