//
//  VENMyBalanceAddAccountViewController.h
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/2.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENBaseViewController.h"

typedef NS_ENUM(NSInteger, VENMyBalanceWithdrawAccountStyle) {
    VENMyBalanceWithdrawAccountStyleAliPay,
    VENMyBalanceWithdrawAccountStyleBankCard
};
@interface VENMyBalanceAddAccountViewController : VENBaseViewController
@property (nonatomic) VENMyBalanceWithdrawAccountStyle withdrawAccountStyle;

@end
