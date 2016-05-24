//
//  WTNHomeViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import "WTNHomeViewController.h"

@interface WTNHomeViewController ()

@end

@implementation WTNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    self.tabBar.barTintColor = [UIColor blackColor];
    UIStoryboard * sportsSB = [UIStoryboard storyboardWithName:@"Sports" bundle:nil];
    UIViewController * sportsVC = [sportsSB instantiateInitialViewController];
    sportsVC.tabBarItem = [self createTabBarItemWithTitle:@"体育" imageName:@"sports_forum_off" selectedImageName:@"sports_forum_on"];
    [self setTabBarItemColorAndSelectColor:sportsVC.tabBarItem];
 
    UIStoryboard * movieSB = [UIStoryboard storyboardWithName:@"Movie" bundle:nil];
    UIViewController * movieVC = [movieSB instantiateInitialViewController];
    movieVC.tabBarItem = [self createTabBarItemWithTitle:@"电影" imageName:@"movie_tab3_nm" selectedImageName:@"movie_tab3_on"];
    [self setTabBarItemColorAndSelectColor:movieVC.tabBarItem];
    
    UIStoryboard * hotAiticleSB = [UIStoryboard storyboardWithName:@"HotAiticle" bundle:nil];
    UIViewController * hotAiticleVC = [hotAiticleSB instantiateInitialViewController];
    hotAiticleVC.tabBarItem = [self createTabBarItemWithTitle:@"热文" imageName:@"hotArtical_tab1_nm" selectedImageName:@"hotArtical_tab1_on"];
    [self setTabBarItemColorAndSelectColor:hotAiticleVC.tabBarItem];
    
    UIStoryboard * PersonalSB = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    UIViewController * PersonalVC = [PersonalSB instantiateInitialViewController];
    PersonalVC.tabBarItem = [self createTabBarItemWithTitle:@"我的" imageName:@"personal_tab4_nm" selectedImageName:@"personal_tab4_on"];
    [self setTabBarItemColorAndSelectColor:PersonalVC.tabBarItem];

    
    self.viewControllers = @[hotAiticleVC,movieVC, sportsVC,PersonalVC];

}
-(UITabBarItem *)createTabBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    return [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}
-(void)setTabBarItemColorAndSelectColor:(UITabBarItem *)item{
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
