//
//  WTNFreeResponsViewController.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNFreeResponsViewController.h"

@interface WTNFreeResponsViewController ()

@end

@implementation WTNFreeResponsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configUI{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-30*2, SCREEN_HEIGHT-50*2)];
    self.view.backgroundColor = HGColor(237, 237, 237);
    label.text = @"任何用户在使用本软件之前,均应仔细阅读本声明(未成年人应当在其法定监护人陪同下阅读),用户可选择不使用本软件服务,一旦使用,即被视为对本声明全部内容的认可和接受。\n\n1.任何通过本软件显示或缓存的资源和产品均系自动搜录第三方网站所有者制作或提供的内容。本软件中的所有材料、信息和产品仅按原样提供,本软件对其合法性、准确性、真实性适用性、安全性等概不负责，也无法负责。\n\n 2.用户不得利用本软件发表、传送、传播、储存违反国家法律、危害国家安全、祖国统一、社会稳定的内容，或任何不当的、侮辱诽谤的、淫秽的、暴力的及任何违反国家法律法规政策的内容。 \n\n3.对于因不可抗力或本软件不能控制的原因造成的网络服务中断或其它缺陷，本软件不承担任何责任，但将尽力减少因此而给用户造成的损失和影响。";
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
}



@end
