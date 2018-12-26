//
//  VENShoppingCartPlacingOrderPaymentOrderViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/25.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartPlacingOrderPaymentOrderViewController.h"
#import "VENShoppingCartPlacingOrderPaymentOrderTableViewCell.h"
#import "VENShoppingCartPlacingOrderSuccessViewController.h"

@interface VENShoppingCartPlacingOrderPaymentOrderViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENShoppingCartPlacingOrderPaymentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"支付订单";
    
    [self setupTableView];
    [self setupBottomToolBarButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENShoppingCartPlacingOrderPaymentOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.leftImageView.image = [UIImage imageNamed:@"icon_pay_01"];
        cell.titleLabel.text = @"微信支付";
    } else if (indexPath.row == 1) {
        cell.leftImageView.image = [UIImage imageNamed:@"icon_pay_02"];
        cell.titleLabel.text = @"支付宝";
    } else if (indexPath.row == 2) {
        cell.leftImageView.image = [UIImage imageNamed:@"icon_pay_03"];
        cell.titleLabel.text = @"银联支付";
    } else if (indexPath.row == 3) {
        cell.leftImageView.image = [UIImage imageNamed:@"icon_pay_04"];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"余额支付（¥39.00）"];
        [attributedString setAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xCCCCCC)} range:NSMakeRange(4, attributedString.length - 4)];
        cell.titleLabel.attributedText = attributedString;
    }
    
    cell.errorLabel.hidden = indexPath.row == 3 ? NO : YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 3 ? 70 : 54;
    
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - 48) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartPlacingOrderPaymentOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    // 分割线
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, kMainScreenWidth, 17)];
    titleLabel.text = @"订单总金额";
    titleLabel.textColor = UIColorFromRGB(0x999999);
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 + 15 + 15, kMainScreenWidth, 24)];
    priceLabel.textColor = UIColorFromRGB(0x1A1A1A);
    priceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0f];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"¥39.00"];
    [attributedString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} range:NSMakeRange(0, 1)];
    priceLabel.attributedText = attributedString;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:priceLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, kMainScreenWidth, 10)];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [headerView addSubview:lineView];
}

- (void)setupBottomToolBarButton {
    UIButton *bottomToolBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - 48 - statusNavHeight, kMainScreenWidth, 48)];
    bottomToolBarButton.backgroundColor = COLOR_THEME;
    bottomToolBarButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    bottomToolBarButton.titleLabel.textColor = [UIColor whiteColor];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"确认支付¥39.00"];
    [attributedString setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} range:NSMakeRange(5, attributedString.length - 5)];
    [bottomToolBarButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [bottomToolBarButton addTarget:self action:@selector(bottomToolBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomToolBarButton];
}

- (void)bottomToolBarButtonClick {
    NSLog(@"确认支付");
    
    VENShoppingCartPlacingOrderSuccessViewController *vc = [[VENShoppingCartPlacingOrderSuccessViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
