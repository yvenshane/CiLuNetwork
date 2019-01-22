//
//  VENMyOrderOrderDetailsViewController.h
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/27.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENBaseViewController.h"

typedef NS_ENUM(NSInteger, VENMyOrderStatusStyle) {
    VENMyOrderStatusStyleWaitingForPayment,
    VENMyOrderStatusStyleWaitingForShipment,
    VENMyOrderStatusStyleWaitingForReceiving,
    VENMyOrderStatusStyleWaitingForEvaluation,
    VENMyOrderStatusStyleCompleted
};

@interface VENMyOrderOrderDetailsViewController : VENBaseViewController
@property (nonatomic) VENMyOrderStatusStyle statusStyle;
@property (nonatomic, copy) NSString *order_id;

@end
