//
//  VENHomePageCollectionViewCell.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/4.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENHomePageCollectionViewCell.h"

@implementation VENHomePageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _videoView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
