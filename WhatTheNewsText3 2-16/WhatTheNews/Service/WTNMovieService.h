//
//  WTNMovieService.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompleteHandle)(id data);
@interface WTNMovieService : NSObject
-(void)getMovieList:(CompleteHandle)handle;
-(void)getMovieADList:(CompleteHandle)handle;
-(void)getMovieNewsByIndex:(int)index complete:(CompleteHandle)handle;
-(void)getMovieNewsMoreByIndex:(int)index complete:(CompleteHandle)handle;
@end
