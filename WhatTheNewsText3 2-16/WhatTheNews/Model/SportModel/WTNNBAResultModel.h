//
//  WTNNBAResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNNBAVideoModel.h"
@interface WTNNBAResultModel : JSONModel
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, strong)NSArray<WTNNBAVideoModel> * toplist;

@end
