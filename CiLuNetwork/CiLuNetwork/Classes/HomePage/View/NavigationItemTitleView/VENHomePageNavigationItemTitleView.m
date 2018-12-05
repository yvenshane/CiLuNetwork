//
//  VENHomePageNavigationItemTitleView.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/4.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENHomePageNavigationItemTitleView.h"

@interface VENHomePageNavigationItemTitleView ()
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation VENHomePageNavigationItemTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        UIButton *leftButton = [[UIButton alloc] init];
        leftButton.selected = YES;
        leftButton.userInteractionEnabled = NO;
        [leftButton setTitle:@"正雷太极" forState:UIControlStateNormal];
        [leftButton setTitleColor:COLOR_THEME forState:UIControlStateSelected];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftButton];
        
        UIView *leftView = [[UIView alloc] init];
        leftView.backgroundColor = COLOR_THEME;
        [self addSubview:leftView];
        
        UIButton *rightButton = [[UIButton alloc] init];
        [rightButton setTitle:@"赐路赢" forState:UIControlStateNormal];
        [rightButton setTitleColor:COLOR_THEME forState:UIControlStateSelected];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
        UIView *rightView = [[UIView alloc] init];
        rightView.hidden = YES;
        rightView.backgroundColor = COLOR_THEME;
        [self addSubview:rightView];
        
        self.leftButton = leftButton;
        self.rightButton = rightButton;
        self.leftView = leftView;
        self.rightView = rightView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftButton.frame = CGRectMake(0, 0, self.titleViewWidth / 2, 34);
    CGFloat leftViewWidth = [self label:self.leftButton.titleLabel setWidthToHeight:19.5f];
    self.leftView.frame = CGRectMake((self.titleViewWidth / 2 - leftViewWidth) / 2, 34, leftViewWidth, 2);

    self.rightButton.frame = CGRectMake(self.titleViewWidth / 2, 0, self.titleViewWidth / 2, 34);
    CGFloat rightViewWidth = [self label:self.rightButton.titleLabel setWidthToHeight:19.5f];
    self.rightView.frame = CGRectMake(self.titleViewWidth / 2 + (self.titleViewWidth / 2 - rightViewWidth) / 2, 34, rightViewWidth, 2);
}


- (void)leftButtonClick {
    self.leftButton.selected = YES;
    self.rightButton.selected = NO;
    
    self.leftView.hidden = NO;
    self.rightView.hidden = YES;
    
    self.leftButton.userInteractionEnabled = NO;
    self.rightButton.userInteractionEnabled = YES;
    
    self.buttonClickBlock(@"left");
}

- (void)rightButtonClick {
    self.leftButton.selected = NO;
    self.rightButton.selected = YES;
    
    self.leftView.hidden = YES;
    self.rightView.hidden = NO;
    
    self.leftButton.userInteractionEnabled = YES;
    self.rightButton.userInteractionEnabled = NO;
    
    self.buttonClickBlock(@"right");
}

- (CGFloat)label:(UILabel *)label setWidthToHeight:(CGFloat)Height {
    CGSize size = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, Height)];
    return size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
