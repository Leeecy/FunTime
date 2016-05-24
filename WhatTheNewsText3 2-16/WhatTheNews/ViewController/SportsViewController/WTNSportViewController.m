//
//  WTNSportViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/4.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNSportViewController.h"
#import "WTNSportTitleView.h"
#import "WTNBasketballViewController.h"
#import "WTNFootballViewController.h"
#import "WTNSportVideoViewController.h"
#import "UIView+WTNCL.h"
@interface WTNSportViewController ()<UIScrollViewDelegate,WTNTitleViewDelegate>{
    WTNBasketballViewController *basket;
    WTNFootballViewController *foot;
    WTNSportVideoViewController *video;
}
@property (nonatomic,copy) NSMutableArray *childViews;
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) WTNSportTitleView *titView;

@end

@implementation WTNSportViewController
-(NSMutableArray *)childViews
{
    if(!_childViews){
        _childViews=[NSMutableArray array];
    }
    return _childViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //2.添加titleView
    [self setupTitleView];
    //3.添加滚动视图
    [self setupScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  添加titleview视图
-(void)setupTitleView
{
    WTNSportTitleView *tv=[[WTNSportTitleView alloc]init];
    // tv.backgroundColor=[UIColor redColor];
    tv.delegate=self;
    tv.frame=CGRectMake(0, 0, 200, 30);
    self.navigationItem.titleView=tv;
    self.titView=tv;
}

#pragma mark 添加titleView的代理方法
-(void)titleView:(WTNSportTitleView *)titleView scrollToIndex:(NSInteger)tagIndex
{
    
    [self.scrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH*tagIndex, 0, self.view.width, self.view.height) animated:YES];
}



#pragma mark 添加滚动视图
-(void)setupScroll
{
    //1.NBA
    basket=[[WTNBasketballViewController alloc]init];
    [self addChildViewController:basket];
    //2.足球控制器
   foot=[[WTNFootballViewController alloc]init];
    [self addChildViewController:foot];
    //3.视频
    video =[[WTNSportVideoViewController alloc]init];
    [self addChildViewController:video];
    //这这几个自控制器的view添加到数组中
    [self.childViews addObject:basket.view];
    [self.childViews addObject:foot.view];
    [self.childViews addObject:video.view];
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    for(int i=0;i<self.childViews.count;i++){
        
        CGFloat childVX=SCREEN_WIDTH*i;
        UIView *childV=self.childViews[i];
        childV.frame=CGRectMake(childVX, 0, SCREEN_WIDTH, self.view.height);
        [scrollView addSubview:childV];
    }
    
    //设置滚动的属性
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*3, 0);
    scrollView.bounces=NO;
    self.scrollView=scrollView;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    if(scrollView.contentOffset.x/SCREEN_WIDTH==0){
        [self.titView wanerSelected:0];
        basket.view.hidden = NO;
        foot.view.hidden = YES;
        video.view.hidden = YES;
    }else if(scrollView.contentOffset.x/SCREEN_WIDTH==1){
        [self.titView wanerSelected:1];
        foot.view.hidden = NO;
        basket.view.hidden = YES;
        video.view.hidden = YES;
    }else if(scrollView.contentOffset.x/SCREEN_WIDTH==2){
        [self.titView wanerSelected:2];
        video.view.hidden = NO;
        foot.view.hidden = YES;
        basket.view.hidden = YES;
    }
}
@end
