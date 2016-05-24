//
//  WTNFootballTableViewCell.m
//  WhatTheNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cl. All rights reserved.
//

#import "WTNFootballTableViewCell.h"

@implementation WTNFootballTableViewCell

- (void)awakeFromNib {
    _footballImageIcon.layer.cornerRadius = 10;
    self.footballImageIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//选中一行跳转
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //在Sports storyBoard 设置 view controller继承 LLFAppDetailViewController  storyBoard ID 为 LLFAppDetailViewController
}
@end
