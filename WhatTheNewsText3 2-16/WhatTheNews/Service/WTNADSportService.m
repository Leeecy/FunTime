//
//  WTNADSportService.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/19.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNADSportService.h"
#import "AFHTTPRequestOperationManager.h"
#import "WTNNBAResultModel.h"
@implementation WTNADSportService
-(void)getADImageList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:NBA_NEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject[@"toplist"]) {
            NSArray *arr = responseObject[@"toplist"];
            for (NSDictionary *dic in arr) {
                WTNNBAVideoModel *model = [[WTNNBAVideoModel alloc]initWithDictionary:dic error:nil];
                if (dic[@"thumbnail"]) {
                    [resultArr addObject:model.thumbnail];
                }
            }
        }
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getADLabelList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:NBA_NEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject[@"toplist"]) {
            NSArray *arr = responseObject[@"toplist"];
            for (NSDictionary *dic in arr) {
                WTNNBAVideoModel *model = [[WTNNBAVideoModel alloc]initWithDictionary:dic error:nil];
                if (dic[@"title"]) {
                    [resultArr addObject:model.title];
                }
            }
        }
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getADdetail:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:NBA_NEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject[@"toplist"]) {
            NSArray *arr = responseObject[@"toplist"];
            for (NSDictionary *dic in arr) {
                WTNNBAVideoModel *model = [[WTNNBAVideoModel alloc]initWithDictionary:dic error:nil];
                if (dic[@"url"]) {
                    [resultArr addObject:model.url];
                }
            }
        }
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
