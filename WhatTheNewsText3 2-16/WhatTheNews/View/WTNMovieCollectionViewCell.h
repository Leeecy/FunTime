//
//  WTNMovieCollectionViewCell.h
//  WhatTheNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTNMovieCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieImageIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieDescription;

@end
