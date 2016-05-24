//
//  WTNFootballTableViewCell.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTNFootballTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *footballImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *footballTitleName;
@property (weak, nonatomic) IBOutlet UILabel *footballUpdateTime;


@end
