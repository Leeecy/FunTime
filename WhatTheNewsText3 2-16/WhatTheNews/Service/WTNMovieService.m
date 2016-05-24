//
//  WTNMovieService.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import "WTNMovieService.h"
#import "WTNMovieResultModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "WTNMovieADResultModel.h"
#import "WTNMovieNewsModel.h"
@implementation WTNMovieService
-(void)getMovieList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:MOVIE_LIST_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        WTNMovieResultModel *model = [[WTNMovieResultModel alloc]initWithData:responseObject error:nil];
//        if (model) {
//            handle(model.resultArr);
//        }
        NSMutableArray *resultArr = [NSMutableArray new];
        if (responseObject[@"result"]) {
            NSArray *arr = responseObject[@"result"] ;
            NSDictionary *dic = [arr firstObject];
                if (dic[@"list"]) {
                    NSArray *listArr = dic[@"list"];
                    for (NSDictionary *mdic in listArr) {
                        WTNListModel *model = [[WTNListModel alloc] initWithDictionary:mdic error:nil];
                        [resultArr addObject:model];
                    }
                }
        }
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);

    }];
}
-(void)getMovieADList:(CompleteHandle)handle{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:MOVIE_LIST_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            WTNMovieADResultModel *model = [[WTNMovieADResultModel alloc]initWithData:responseObject error:nil];
                handle(model.filmList);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}

-(void)getMovieNewsByIndex:(int)index complete:(CompleteHandle)handle{
    //拼接详细地址
    NSString *path = [NSString stringWithFormat:@"%@%d",MOVIE_NEWS_URL,index];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WTNMovieNewsModel *model = [[WTNMovieNewsModel alloc]initWithData:responseObject error:nil];
        handle(model.filmList);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];

}
-(void)getMovieNewsMoreByIndex:(int)index complete:(CompleteHandle)handle{
    //拼接详细地址   appId 到限免接口 "applicationId"
    NSString *path = [NSString stringWithFormat:@"%@%d",MOVIE_NEWS_URL,index];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        WTNMovieNewsModel *model = [[WTNMovieNewsModel alloc]initWithData:responseObject error:nil];
        handle(model.filmList);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    

}
@end





