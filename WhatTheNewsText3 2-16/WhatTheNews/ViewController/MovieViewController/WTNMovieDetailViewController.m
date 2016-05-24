//
//  WTNMovieDetailViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/26.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNMovieDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "WTNMovieDataModel.h"
#import "WTNMovieDetail.h"
#import "WTNListModel.h"
#import "WTNMoviePlayViewController.h"
#import "WTNMovieVideoModel.h"
#import "UIView+WTNCL.h"
#import "AFHTTPRequestOperationManager.h"

#define TAG 10002
@interface WTNMovieDetailViewController (){
    NSMutableArray *_resultArr;
    NSString *_movieUrl;

    __weak IBOutlet UIImageView *_movieNameImage;
    __weak IBOutlet UILabel *_movieDirector;
    __weak IBOutlet UILabel *_movieName;
    __weak IBOutlet UILabel *_movieType;
    __weak IBOutlet UILabel *_movieTime;
    __weak IBOutlet UILabel *_moviePlace;
    __weak IBOutlet UILabel *_movieActor;
    __weak IBOutlet UILabel *_movieDetail;
    __weak IBOutlet UILabel *_movieState;
    __weak IBOutlet UIButton *_btnPlay;

}

@end

@implementation WTNMovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HGColor(220, 233, 229);
}
-(void)loadData{
//    NSString *str = _movieModel.movieDataId;
//    NSInteger numId = [str integerValue];

    [[WTNMovieDetail new]getMovieDetailByAppId:self.listModel.listId complete:^(id data) {
        if (data) {
            _movieModel = data;
            [_movieNameImage sd_setImageWithURL:[NSURL URLWithString:_movieModel.vthumburl]];
            _movieName.text = _movieModel.programname;
            _movieType.text = [NSString stringWithFormat:@"Type:%@",_movieModel.videotype];
            _movieDirector.text = [NSString stringWithFormat:@"导演:%@",_movieModel.director];
            _movieTime.text = [NSString stringWithFormat:@"上映时间:%@",_movieModel.year];
            _moviePlace.text = [NSString stringWithFormat:@"上映地区:%@",_movieModel.area];
            _movieActor.text = [NSString stringWithFormat:@"影片主演:%@",_movieModel.craw];
            _movieDetail.text = _movieModel.programedesc;
            _movieState.text = @"播放:";

        }
    }];
    [[WTNMovieDetail new]getMovieUrlByAppId:self.listModel.listId complete:^(id data) {
        if (data) {
            _resultArr = data;
            if (_resultArr[0]) {
                 _movieUrl = _resultArr[0];
                [_btnPlay setTitle:@"地址一" forState:(UIControlStateNormal)];
                _btnPlay.backgroundColor = HGColor(210, 210, 210);
                [_btnPlay  addTarget:self action:@selector(btnVideoPlay:) forControlEvents:(UIControlEventTouchUpInside)];
            }
        }
    }];
}
-(IBAction)btnVideoPlay:(UIButton*)sender{
    WTNMoviePlayViewController *MPvc = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNMoviePlayViewController"];
    MPvc.videoUrlDes = _movieUrl;
    [self.navigationController pushViewController:MPvc animated:YES];
}
@end





