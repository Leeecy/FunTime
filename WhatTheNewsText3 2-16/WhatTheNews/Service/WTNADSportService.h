//
//  WTNADSportService.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompleteHandle)(id data);
@interface WTNADSportService : NSObject
-(void)getADImageList:(CompleteHandle)handle;
-(void)getADLabelList:(CompleteHandle)handle;
-(void)getADdetail:(CompleteHandle)handle;
@end
