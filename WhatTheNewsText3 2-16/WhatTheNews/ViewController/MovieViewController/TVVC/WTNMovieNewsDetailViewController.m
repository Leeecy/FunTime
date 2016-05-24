//
//  WTNMovieNewsDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/6.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNMovieNewsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "WTNMovieDetail.h"
#import "WTNMovieNewDetailModel.h"
#import "WTNFilmNewsListModel.h"
#import "WTNFilmListDetail.h"
@interface WTNMovieNewsDetailViewController (){
    __weak IBOutlet UIImageView *_movieNameImage;
    __weak IBOutlet UILabel *_movieType;
    __weak IBOutlet UILabel *_movieScore;
    __weak IBOutlet UILabel *_moviePlace;
    __weak IBOutlet UILabel *_movieDetail;
    __weak IBOutlet UILabel *_movieDes;
}

@end

@implementation WTNMovieNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)loadata{
    [[WTNMovieDetail new]getMovieNewDetailByFilmId:self.newsListModel.filmID complete:^(id data) {
//        NSLog(@"self.newsListModel.filmID = %@",self.newsListModel.filmID);
        if (data) {
           _filmListDetail = data;
           [_movieNameImage sd_setImageWithURL:[NSURL URLWithString:_filmListDetail.posterAddress]];
             _movieScore.text = [NSString stringWithFormat:@"评分:%@",_filmListDetail.grade];
            _movieType.text = [NSString stringWithFormat:@"%@",_filmListDetail.filmType];
           _movieDes.text = @"简介";
           _moviePlace.text = [NSString stringWithFormat:@"上映地区:%@",_filmListDetail.nation];
            _movieDetail.text = _filmListDetail.synopsis;
        }

    }];
}

@end












