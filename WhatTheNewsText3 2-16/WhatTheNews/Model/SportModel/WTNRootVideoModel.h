//
//  WTNRootVideoModel.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol WTNRootVideoModel
@end
@interface WTNRootVideoModel : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *type;
//图片数组只有一个属性
@property (nonatomic, strong)NSArray<Optional> *images;
@end
