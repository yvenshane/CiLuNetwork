//
//  VENMyOrderOrderDetailsViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/27.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyOrderOrderDetailsViewController.h"
#import "VENShoppingCartTableViewCell.h"
#import "VENMyOrderOrderDetailsTableViewCell.h"
#import "VENMyOrderOrderDetailsFooterView.h"
#import "VENMyOrderOrderDetailsHeaderView.h"
#import "VENMyOrderOrderDetailsOrderEvaluationViewController.h"

@interface VENMyOrderOrderDetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *cellIdentifier2 = @"cellIdentifier2";
@implementation VENMyOrderOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订单详情";

    [self setupTableView];
    
    if (self.statusStyle != VENMyOrderStatusStyleWaitingForShipment && self.statusStyle != VENMyOrderStatusStyleCompleted) {
        [self setupBottomToolBar];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.statusStyle == VENMyOrderStatusStyleWaitingForReceiving || self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation ? 3 : 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VENShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.iconImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        cell.priceLabel.textColor = UIColorFromRGB(0x1A1A1A);
        cell.iconImageViewLayoutConstraint.constant = -33.0f;
        cell.choiceButton.hidden = YES;
        
        return cell;
    } else {
        VENMyOrderOrderDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftLabel.text = indexPath.section == 1 ? @[@"订单编号：", @"下单时间：", @"支付方式：", @"留言备注："][indexPath.row] : @[@"快递名称：", @"快递单号："][indexPath.row];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 100 : 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        VENMyOrderOrderDetailsHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"VENMyOrderOrderDetailsHeaderView" owner:nil options:nil] lastObject];
        
        NSString *titleStr = @"";
        NSString *contentStr = @"";
        if (self.statusStyle == VENMyOrderStatusStyleWaitingForPayment) {
            titleStr = @"订单待支付";
            contentStr = @"当前订单未支付，请您尽快支付订单";
        } else if (self.statusStyle == VENMyOrderStatusStyleWaitingForShipment) {
            titleStr = @"订单待发货";
            contentStr = @"订单已支付，等待商家发货";
        } else if (self.statusStyle == VENMyOrderStatusStyleWaitingForReceiving) {
            titleStr = @"订单待收货";
            contentStr = @"商家已发货，请注意查收";
        } else if (self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation) {
            titleStr = @"订单待评价";
            contentStr = @"您已收货，给我们一个评价吧";
        } else if (self.statusStyle == VENMyOrderStatusStyleCompleted) {
            titleStr = @"订单已完成";
            contentStr = @"您已评价，订单已完成";
        }
        
        headerView.titleLabel.text = titleStr;
        headerView.contentLabel.text = contentStr;
        
        return headerView;
    } else if (section == 2) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
        lineView.backgroundColor = UIColorMake(245, 245, 245);
        [headerView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 13.5 + 10, kMainScreenWidth - 30, 17)];
        titleLabel.text = @"物流信息";
        titleLabel.textColor = UIColorFromRGB(0x1A1A1A);
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        [headerView addSubview:titleLabel];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(15, 54, kMainScreenWidth, 1)];
        lineView2.backgroundColor = UIColorFromRGB(0xE8E8E8);
        [headerView addSubview:lineView2];
        
        return headerView;
    } else {
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 208;
    } else if (section == 2) {
        return 54;
    } else {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        VENMyOrderOrderDetailsFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"VENMyOrderOrderDetailsFooterView" owner:nil options:nil] lastObject];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"实付 ¥400.00"];
        [attributedString addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xD0021B), NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14.0f]} range:NSMakeRange(3, attributedString.length - 3)];
        footerView.totalPriceLabel.attributedText = attributedString;
        
        return footerView;
    } else {
        return [[UIView alloc] init];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 0 ? 99 : 0.01;
}

- (void)setupTableView {
    
    CGFloat height = self.statusStyle != VENMyOrderStatusStyleWaitingForShipment && self.statusStyle != VENMyOrderStatusStyleCompleted ? kMainScreenHeight - statusNavHeight - 48 : kMainScreenHeight - statusNavHeight;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, height) style:UITableViewStyleGrouped];

    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"VENMyOrderOrderDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    [self.view addSubview:tableView];
}

- (void)setupBottomToolBar {
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - statusNavHeight - 48, kMainScreenWidth, 48)];
    bottomToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomToolBar];
    
    if (self.statusStyle == VENMyOrderStatusStyleWaitingForPayment) {
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth / 2, 48)];
        [leftButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [leftButton setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [bottomToolBar addSubview:leftButton];
    }
    
    CGFloat x = self.statusStyle == VENMyOrderStatusStyleWaitingForReceiving || self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation ? 0 : kMainScreenWidth / 2;
    
    CGFloat width = self.statusStyle == VENMyOrderStatusStyleWaitingForReceiving || self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation ? kMainScreenWidth : kMainScreenWidth / 2;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, 48)];
    rightButton.backgroundColor = UIColorFromRGB(0xC7974F);
    
    NSString *titelStr = @"";
    if (self.statusStyle == VENMyOrderStatusStyleWaitingForPayment) {
        titelStr = @"去支付";
    } else if (self.statusStyle == VENMyOrderStatusStyleWaitingForReceiving) {
        titelStr = @"确认收货";
    } else if (self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation) {
        titelStr = @"评价";
    }
    
    [rightButton setTitle:titelStr forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolBar addSubview:rightButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth / 2, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xE8E8E8);
    if (self.statusStyle != VENMyOrderStatusStyleWaitingForReceiving && self.statusStyle != VENMyOrderStatusStyleWaitingForEvaluation) {
        [bottomToolBar addSubview:lineView];
    }
}

- (void)rightButtonClick {
    if (self.statusStyle == VENMyOrderStatusStyleWaitingForEvaluation) {
        VENMyOrderOrderDetailsOrderEvaluationViewController *vc = [[VENMyOrderOrderDetailsOrderEvaluationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
