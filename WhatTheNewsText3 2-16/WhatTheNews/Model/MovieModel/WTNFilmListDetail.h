//
//  WTNFilmListDetail.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/8.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol  WTNFilmListDetail

@end
@interface WTNFilmListDetail : JSONModel
@property (nonatomic, copy) NSString *language;
@property (nonatomic, copy) NSString *displayIndex;
@property (nonatomic, copy) NSString *bigPoster;
@property (nonatomic, copy) NSString *filmType;
@property (nonatomic, copy) NSString *filmID;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *sceneCount;
@property (nonatomic, copy) NSString *prevueAddress;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *cinemaCount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *watchFilm;
@property (nonatomic, copy) NSString *length;
@property (nonatomic, copy) NSString *posterAddress;
@property (nonatomic, copy) NSString *filmName;
@property (nonatomic, copy) NSString *displayFlag;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *director;
@property (nonatomic, copy) NSString *firstPlayTime;
@property (nonatomic, copy) NSString *showFlag;
@property (nonatomic, copy) NSString *englishName;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *isLike;
@end
