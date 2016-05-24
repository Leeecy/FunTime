//
//  WTNFootballService.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNFootballService.h"
#import "WTNFootballResultModel.h"
#import "WTNNBAResultModel.h"
#import "WTNSportVideoResultModel.h"
#import "AFHTTPRequestOperationManager.h"
@implementation WTNFootballService
-(void)getFootballList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:FOOT_NEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            WTNFootballResultModel *model = [[WTNFootballResultModel alloc]initWithData:responseObject error:nil];
             handle(model.toplistArr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
-(void)getNBAList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:NBA_NEWS_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject) {
            WTNNBAResultModel *model = [[WTNNBAResultModel alloc]initWithData:responseObject error:nil];
            handle(model.toplist);   
        }
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}
-(void)getSportVideo:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:SPORT_VIDEO_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            {
            WTNSportVideoResultModel *model = [[WTNSportVideoResultModel alloc]initWithDictionary:responseObject error:nil];
                handle(model.stories);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}
-(void)getSportBackground:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:SPORT_VIDEO_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject[@"background"]) {
            {
                NSDictionary *dic = responseObject[@"background"];
                [resultArr addObject:dic];
            }
        }
         handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}
@end







