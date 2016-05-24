//
//  WTNNBAVideoModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/29.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol WTNNBAVideoModel

@end
@interface WTNNBAVideoModel : JSONModel
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *lable;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *way;
@property (nonatomic, copy) NSString *shortTitle;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *porder;
@property (nonatomic, copy) NSString *from_name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *updatetime;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *indextitle;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *from_url;
@end
