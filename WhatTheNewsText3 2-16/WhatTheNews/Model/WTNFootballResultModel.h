//
//  WTNFootballResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNTopListModel.h"
@interface WTNFootballResultModel : JSONModel
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, strong)NSArray<WTNTopListModel> * toplistArr;
@end
