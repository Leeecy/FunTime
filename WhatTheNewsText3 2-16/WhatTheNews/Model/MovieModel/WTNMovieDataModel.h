//
//  WTNMovieDataModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface WTNMovieDataModel : JSONModel
@property (nonatomic, copy) NSString *craw;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *programname;
@property (nonatomic, strong) NSString *movieDataId;
@property (nonatomic, copy) NSString *l;
@property (nonatomic, copy) NSString *vthumburl;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *videotype;
@property (nonatomic, copy) NSString *programedesc;
@property (nonatomic, copy) NSString *episode;
@property (nonatomic, copy) NSString *director;
@end
