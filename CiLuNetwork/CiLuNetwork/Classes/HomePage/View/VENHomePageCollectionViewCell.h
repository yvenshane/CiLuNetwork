//
//  VENHomePageCollectionViewCell.h
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/4.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VENHomePageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *mainBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
