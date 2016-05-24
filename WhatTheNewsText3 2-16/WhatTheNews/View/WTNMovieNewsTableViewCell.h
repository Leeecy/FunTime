//
//  WTNMovieNewsTableViewCell.h
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTNMovieNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieTime;
@property (weak, nonatomic) IBOutlet UILabel *movieNation;
@property (weak, nonatomic) IBOutlet UILabel *movieType;
@property (weak, nonatomic) IBOutlet UILabel *movieScore;
@end
