//
//  WTNMovieDetail.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompleteHandle)(id data);
@interface WTNMovieDetail : NSObject
-(void)getMovieDetailByAppId:(NSString*)appId complete:(CompleteHandle)handle;
-(void)getMovieUrlByAppId:(NSString*)appId complete:(CompleteHandle)handle;
-(void)getMovieNewDetailByFilmId:(NSString*)filmId complete:(CompleteHandle)handle;
@end
