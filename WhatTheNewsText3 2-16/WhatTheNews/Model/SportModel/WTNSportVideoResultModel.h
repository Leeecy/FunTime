//
//  WTNSportVideoResultModel.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNRootVideoModel.h"
@interface WTNSportVideoResultModel : JSONModel
@property (nonatomic, strong) NSNumber *color;
@property (nonatomic, copy) NSString *image_source;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *appDescription;
@property (nonatomic, copy) NSString *background;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong)NSArray<WTNRootVideoModel> * stories;
@property (nonatomic, strong)NSArray<Optional> * editors;
@end
