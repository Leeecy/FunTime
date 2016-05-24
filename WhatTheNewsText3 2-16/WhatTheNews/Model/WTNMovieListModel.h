//
//  WTNMovieListModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "WTNListModel.h"
@protocol WTNMovieListModel
@end
@interface WTNMovieListModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<WTNListModel> * listArr;

@end
