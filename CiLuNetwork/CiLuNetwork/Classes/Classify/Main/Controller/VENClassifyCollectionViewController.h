//
//  VENClassifyCollectionViewController.h
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/14.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENBaseViewController.h"

typedef void (^collectionViewDidSelectBlock)(NSString *);
@interface VENClassifyCollectionViewController : UICollectionViewController
@property (nonatomic, copy) collectionViewDidSelectBlock block;

@end
