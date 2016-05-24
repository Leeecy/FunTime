//
//  WTNMovieVideoModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"JSONModel.h"
@protocol WTNMovieVideoModel
@end
@interface WTNMovieVideoModel : JSONModel
@property (nonatomic, copy) NSString *videourl;
@property (nonatomic, strong) NSNumber *play;
@property (nonatomic, strong)NSArray <Optional>*urls;
@end
