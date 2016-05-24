//
//  WTNFilmNewsListModel.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol WTNFilmNewsListModel

@end
@interface WTNFilmNewsListModel : JSONModel
@property (nonatomic, copy) NSString *minposterAddress;
@property (nonatomic, copy) NSString *nearShowCount;
@property (nonatomic, copy) NSString *displayIndex;
@property (nonatomic, copy) NSString *filmType;
@property (nonatomic, copy) NSString *filmID;
@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *sceneCount;
@property (nonatomic, copy) NSString *shortIntro;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *topFlag;
@property (nonatomic, copy) NSString *cinemaCount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *nation;
@property (nonatomic, copy) NSString *watchFilm;
@property (nonatomic, copy) NSString *posterAddress;
@property (nonatomic, copy) NSString *filmName;
@property (nonatomic, copy) NSString *horizontalLogo;
@property (nonatomic, copy) NSString *displayFlag;
@property (nonatomic, copy) NSString *grade;
@property (nonatomic, copy) NSString *firstPlayTime;
@end
