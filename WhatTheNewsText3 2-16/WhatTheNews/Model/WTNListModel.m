//
//  WTNListModel.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNListModel.h"

@implementation WTNListModel
+(JSONKeyMapper*)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"listId"}];
}
@end
