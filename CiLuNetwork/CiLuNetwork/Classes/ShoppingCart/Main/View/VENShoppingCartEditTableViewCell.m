//
//  VENShoppingCartEditTableViewCell.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/12.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartEditTableViewCell.h"

@implementation VENShoppingCartEditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.plusButton setTitleColor:UIColorFromRGB(0xB2B2B2) forState:UIControlStateNormal];
    self.plusButton.layer.borderWidth = 1.0f;
    self.plusButton.layer.borderColor = UIColorFromRGB(0xB2B2B2).CGColor;
    
    [self.minusButton setTitleColor:UIColorFromRGB(0xB2B2B2) forState:UIControlStateNormal];
    self.minusButton.layer.borderWidth = 1.0f;
    self.minusButton.layer.borderColor = UIColorFromRGB(0xB2B2B2).CGColor;
    
    self.numberLabel.layer.borderWidth = 1.0f;
    self.numberLabel.layer.borderColor = UIColorFromRGB(0xB2B2B2).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
