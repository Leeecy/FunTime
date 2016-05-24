//
//  WTNMovieNewsTableViewCell.m
//  WhatTheNews
//
//  Created by qianfeng on 16/1/5.
//  Copyright © 2016年 cl. All rights reserved.
//

#import "WTNMovieNewsTableViewCell.h"

@implementation WTNMovieNewsTableViewCell

- (void)awakeFromNib {
    self.movieScore.font = [UIFont boldSystemFontOfSize:20];
    self.movieScore.textAlignment = NSTextAlignmentCenter;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
