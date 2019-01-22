//
//  VENFilterView.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/10.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENFilterView.h"

@interface VENFilterView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UIButton *backgroundView;
@property (nonatomic, assign) NSInteger categoryIndex;
//@property (nonatomic, assign) NSInteger selecteIndex;
@property (nonatomic, strong) NSMutableDictionary *selecteIndexMuDict;

@end

@implementation VENFilterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"categoryViewClick" object:nil];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorFromRGB(0xF1F1F1);
        [self addSubview:lineView];
        
        UIButton *leftButton = [[UIButton alloc] init];
        [self addSubview:leftButton];
        
        UIButton *rightButton = [[UIButton alloc] init];
        [self addSubview:rightButton];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.text = @"价格";
        leftLabel.font = [UIFont systemFontOfSize:12.0f];
        leftLabel.textColor = UIColorFromRGB(0x1A1A1A);
        [self addSubview:leftLabel];
        
        UIImageView *leftImageView = [[UIImageView alloc] init];
        leftImageView.image = [UIImage imageNamed:@"icon_down02"];
        [self addSubview:leftImageView];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.text = @"销量";
        rightLabel.font = [UIFont systemFontOfSize:12.0f];
        rightLabel.textColor = UIColorFromRGB(0x1A1A1A);
        [self addSubview:rightLabel];
        
        UIImageView *rightImageView = [[UIImageView alloc] init];
        rightImageView.image = [UIImage imageNamed:@"icon_down02"];
        [self addSubview:rightImageView];
        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.backgroundColor = UIColorFromRGB(0xF1F1F1);
        [self addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] init];
        lineView2.backgroundColor = UIColorFromRGB(0xF1F1F1);
        [self addSubview:lineView2];
        
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.categoryIndex = 0;
//        self.selecteIndex = 0;
        self.leftButton = leftButton;
        self.rightButton = rightButton;
        self.leftLabel = leftLabel;
        self.leftImageView = leftImageView;
        self.rightLabel = rightLabel;
        self.rightImageView = rightImageView;
        self.lineView = lineView;
        self.lineView1 = lineView1;
        self.lineView2 = lineView2;
    }
    return self;
}

- (void)leftButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        
        self.leftLabel.textColor = COLOR_THEME;
        self.leftImageView.image = [UIImage imageNamed:@"icon_up02"];
        
        UIButton *backgroundView = [[UIButton alloc] initWithFrame:CGRectMake(0, 141, kMainScreenWidth, kMainScreenHeight - 141)];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [backgroundView addTarget:self action:@selector(backgroundViewClick) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];

        NSArray *titleArr = @[@"价格由高到低", @"价格由低到高"];
        
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, i * 44, kMainScreenWidth, 44)];
            button.tag = i + 1000;
            button.backgroundColor = [UIColor whiteColor];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [backgroundView addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 44 / 2 - 20 / 2, kMainScreenWidth - 15 - 14 - 15, 20)];
            label.text = titleArr[i];
            label.font = [UIFont systemFontOfSize:14.0f];
            
            label.textColor = [self.selecteIndexMuDict[[NSString stringWithFormat:@"%ld", (long)self.categoryIndex]] integerValue] == button.tag ? COLOR_THEME : UIColorFromRGB(0x1A1A1A);
            [button addSubview:label];
            
            UIImageView *iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth - 14 - 15, 44 / 2 - 10 / 2, 14, 10)];
            iamgeView.hidden = [self.selecteIndexMuDict[[NSString stringWithFormat:@"%ld", (long)self.categoryIndex]] integerValue] == button.tag ? NO : YES;
            iamgeView.image = [UIImage imageNamed:@"icon_right02"];
            [button addSubview:iamgeView];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i * 44, kMainScreenWidth, 1)];
            lineView.backgroundColor = UIColorFromRGB(0xF1F1F1);
            [backgroundView addSubview:lineView];
        }

        self.backgroundView = backgroundView;
    } else {
        self.leftLabel.textColor = UIColorFromRGB(0x1A1A1A);
        self.leftImageView.image = [UIImage imageNamed:@"icon_down02"];
        
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
    }
}

- (void)rightButtonClick:(id)sender {
    NSLog(@"右边");
}

- (void)backgroundViewClick {
    
    self.leftButton.selected = NO;
    
    self.leftLabel.textColor = UIColorFromRGB(0x1A1A1A);
    self.leftImageView.image = [UIImage imageNamed:@"icon_down02"];
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)notification:(NSNotification *)noti {
    if (self.categoryIndex != [noti.object integerValue]) {
        
        self.leftButton.selected = NO;
        
        self.leftLabel.textColor = UIColorFromRGB(0x1A1A1A);
        self.leftImageView.image = [UIImage imageNamed:@"icon_down02"];
        
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        
        self.categoryIndex = [noti.object integerValue];
    }
}

- (void)buttonClick:(UIButton *)button {
    
    [self.selecteIndexMuDict setObject:[NSString stringWithFormat:@"%ld", (long)button.tag] forKey:[NSString stringWithFormat:@"%ld", (long)self.categoryIndex]];

    self.leftButton.selected = NO;
    
    self.leftLabel.textColor = UIColorFromRGB(0x1A1A1A);
    self.leftImageView.image = [UIImage imageNamed:@"icon_down02"];
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat leftLabelHeight = [self label:self.leftLabel setWidthToHeight:17];
    CGFloat rightLabelHeight = [self label:self.rightLabel setWidthToHeight:17];
    
    self.leftButton.frame = CGRectMake(0, 0, kMainScreenWidth / 2, 36);
    self.rightButton.frame = CGRectMake(kMainScreenWidth / 2, 0, kMainScreenWidth / 2, 36);
    self.leftLabel.frame = CGRectMake(kMainScreenWidth / 2 / 2  - leftLabelHeight / 2, 36 / 2 - 17 / 2, leftLabelHeight, 17);
    self.rightLabel.frame = CGRectMake(kMainScreenWidth / 2 + kMainScreenWidth / 2 / 2  - rightLabelHeight / 2, 36 / 2 - 17 / 2, rightLabelHeight, 17);
    self.leftImageView.frame = CGRectMake(kMainScreenWidth / 2 / 2  - 11 / 2 + leftLabelHeight / 2 + 10, 36 / 2 - 6 / 2, 11, 6);
    self.rightImageView.frame = CGRectMake(kMainScreenWidth / 2 + kMainScreenWidth / 2 / 2  - 11 / 2 + rightLabelHeight / 2 + 10, 36 / 2 - 6 / 2, 11, 6);
    self.lineView.frame = CGRectMake(0, 0, kMainScreenWidth, 1);
    self.lineView1.frame = CGRectMake(kMainScreenWidth / 2, 36 / 2 - 15 / 2, 1, 15);
    self.lineView2.frame = CGRectMake(0, 36 - 1, kMainScreenWidth, 1);
}

- (CGFloat)label:(UILabel *)label setHeightToWidth:(CGFloat)width {
    CGSize size = [label sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    return size.height;
}

- (CGFloat)label:(UILabel *)label setWidthToHeight:(CGFloat)Height {
    CGSize size = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, Height)];
    return size.width;
}

- (NSMutableDictionary *)selecteIndexMuDict {
    if (_selecteIndexMuDict == nil) {
        _selecteIndexMuDict = [NSMutableDictionary dictionary];
    }
    return _selecteIndexMuDict;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
