//
//  WTNMovieDetail.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieDetail.h"
#import "WTNMovieDetailResultModel.h"
#import "AFHTTPRequestOperationManager.h"
#import "WTNMovieNewDetailModel.h"
@implementation WTNMovieDetail
-(void)getMovieDetailByAppId:(NSString*)appId complete:(CompleteHandle)handle{
   NSString *path = [NSString stringWithFormat:@"%@%@&cli=iphone&sys_ver=8.2&ver=2.3.4",MOVIE_DETAIL_URL,appId];
   // NSString *path = @"http://doukantv.com/api/program/?id=108684&cli=iphone&sys_ver=8.2&ver=2.3.4";
    NSLog(@"appId=%@",appId);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            {
               WTNMovieDetailResultModel *model = [[WTNMovieDetailResultModel alloc]initWithData :responseObject error:nil];
                handle(model.movieData);
            }

        }
       // NSMutableArray *resultArr = [NSMutableArray new];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)getMovieNewDetailByFilmId:(NSString*)filmId complete:(CompleteHandle)handle{
    NSString *path = [NSString stringWithFormat:@"%@%@?revision=4.1",MOVIE_DETAIL_MORE,filmId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
                WTNMovieNewDetailModel *model = [[ WTNMovieNewDetailModel alloc]initWithDictionary:responseObject error:nil];
                    handle([model.filmList firstObject]);
        
            }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(void)getMovieUrlByAppId:(NSString*)appId complete:(CompleteHandle)handle{
    NSString *path = [NSString stringWithFormat:@"%@%@&cli=iphone&sys_ver=8.2&ver=2.3.4",MOVIE_DETAIL_URL,appId];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        if (responseObject[@"videos"]) {
            NSArray *arr = responseObject[@"videos"];
            for (NSDictionary *dic in arr) {
                WTNMovieVideoModel *model = [[WTNMovieVideoModel alloc]initWithDictionary:dic error:nil];
                if (dic[@"videourl"]) {
                    [resultArr addObject:model.videourl];
                }
            }
        }
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
