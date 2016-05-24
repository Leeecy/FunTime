//
//  WTNListModel.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@protocol WTNListModel
@end
@interface WTNListModel : JSONModel
@property (nonatomic, copy) NSString *programname;
@property (nonatomic, copy) NSString *shortdesc;
@property (nonatomic, strong) NSString *listId;
@property (nonatomic, copy) NSString *craw;
@property (nonatomic, copy) NSString *vthumburl;
@end
