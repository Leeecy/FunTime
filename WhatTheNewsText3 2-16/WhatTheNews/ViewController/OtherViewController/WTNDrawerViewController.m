//
//  WTNDrawerViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/28.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNDrawerViewController.h"
#import "WTNHomeViewController.h"
#import "WTNQQViewController.h"
#import "WTNSinaViewController.h"
#import "WTNBaiduViewController.h"
#import "WTNSouhuViewController.h"
@interface WTNDrawerViewController (){
   
    WTNHomeViewController *_homeVC;
    WTNBaiduViewController *_baiduVC;
    WTNSouhuViewController *_souhuVC;
    WTNSinaViewController * _sinaVC;
    WTNQQViewController *_qqVC;
    //摇动或者拖拽手势
    UIPanGestureRecognizer *pan;
    // (平移)手势
    UIScreenEdgePanGestureRecognizer *screenEdgePan;
}
@end

@implementation WTNDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configUI{
    self.view.backgroundColor = HGColor(255, 240, 202);
    //默认关闭
    _isDrawOpen = NO;
    _homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNHomeViewController"];
    [self addChildViewController:_homeVC];
    [self.view addSubview:_homeVC.view];
    screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenPan:)];
     // 屏幕左侧边缘响应
    screenEdgePan.edges = UIRectEdgeLeft;
    // 给self.view添加上
    [self.view addGestureRecognizer:screenEdgePan];
}
-(void)screenPan:(UIScreenEdgePanGestureRecognizer*)recognizer{
    if (recognizer == screenEdgePan) {
        CGPoint point = [recognizer translationInView:self.view];
          NSLog(@"%f", point.x);
        if (point.x > SCREEN_WIDTH * 0.7) {
            
        }else{
//            滑动放大比例
             CGFloat scale = 1;
            _homeVC.view.center = CGPointMake(SCREEN_WIDTH * 0.5 + point.x, _homeVC.view.center.y);
            _homeVC.view.transform = CGAffineTransformMakeScale(scale, scale);
        }
        if (recognizer.state == UIGestureRecognizerStateEnded){
             if (point.x > SCREEN_WIDTH / 2) {
                 [UIView animateWithDuration:0.2 animations:^{
                     _homeVC.view.center = CGPointMake(SCREEN_WIDTH * 1.2, _homeVC.view.center.y);
                     //滑动
                     _homeVC.view.transform = CGAffineTransformMakeScale(1, 1);
                 }];
                 _isDrawOpen = YES;
             }else{
                 [UIView animateWithDuration:0.2 animations:^{
                     _homeVC.view.center = CGPointMake(SCREEN_WIDTH * 0.5, _homeVC.view.center.y);
                     _homeVC.view.transform = CGAffineTransformMakeScale(1, 1);
                 }];
             }
        }
    }
}
-(void)pan:(UIPanGestureRecognizer *)recognzier{
     //获取平移手势对象在self.view的位置点
    if (recognzier == pan) {
        if (_isDrawOpen) {
            CGPoint point = [recognzier translationInView:_homeVC.view];
            NSLog(@"%f",point.x);
        }
    }
}
-(void)clickDrawerButton{
    if (_isDrawOpen) {
        [self closeDrawer];
    }else{
        [self openDrawer];
    }
}
-(void)closeDrawer{
    [UIView animateWithDuration:0.5 animations:^{
        _homeVC.view.center = CGPointMake(SCREEN_WIDTH * 0.5,  _homeVC.view.center.y);
         _homeVC.view.transform = CGAffineTransformMakeScale(1, 1);

    }];
    _isDrawOpen = NO;
}

-(void)openDrawer{
    [UIView animateWithDuration:0.5 animations:^{
         _homeVC.view.center = CGPointMake(SCREEN_WIDTH * 1.2,  _homeVC.view.center.y);
         _homeVC.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    _isDrawOpen = YES;
}
-(IBAction)firstBtnClicked:(id)sender{
    
     _sinaVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNSinaViewController"];
    _sinaVC.hidesBottomBarWhenPushed = YES;
    UINavigationController * selectedVC = _homeVC.selectedViewController;
    [selectedVC pushViewController:_sinaVC animated:NO];
    [self closeDrawer];
}
-(IBAction)secondBtnClicked:(id)sender{
    _qqVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNQQViewController"];
    _qqVC.hidesBottomBarWhenPushed = YES;
    UINavigationController * selectedVC = _homeVC.selectedViewController;
    [selectedVC pushViewController:_qqVC animated:NO];
    [self closeDrawer];
}
-(IBAction)thirdBtnClicked:(id)sender{
    _baiduVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNBaiduViewController"];
    _baiduVC.hidesBottomBarWhenPushed = YES;
    UINavigationController * selectedVC = _homeVC.selectedViewController;
    [selectedVC pushViewController:_baiduVC animated:NO];
    [self closeDrawer];
}
-(IBAction)forthBtnClicked:(id)sender{
    _souhuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WTNSouhuViewController"];
    _souhuVC.hidesBottomBarWhenPushed = YES;
    UINavigationController * selectedVC = _homeVC.selectedViewController;
    [selectedVC pushViewController:_souhuVC animated:NO];
    [self closeDrawer];

}



@end
