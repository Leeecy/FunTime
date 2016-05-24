//
//  WTNFootballService.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompleteHandle)(id data);
@interface WTNFootballService : NSObject
-(void)getFootballList:(CompleteHandle)handle;
-(void)getNBAList:(CompleteHandle)handle;
-(void)getSportVideo:(CompleteHandle)handle;
-(void)getSportBackground:(CompleteHandle)handle;
@end
