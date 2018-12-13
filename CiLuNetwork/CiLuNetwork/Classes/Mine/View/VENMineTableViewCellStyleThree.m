//
//  VENMineTableViewCellStyleThree.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/13.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMineTableViewCellStyleThree.h"

@implementation VENMineTableViewCellStyleThree

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconButton.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    self.iconButton.layer.cornerRadius = 36.0f;
    self.iconButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
