//
//  VENMyBalanceRechargeViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/2.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyBalanceRechargeViewController.h"
#import "VENMyBalanceRechargeTableViewCell.h"
#import "VENShoppingCartPlacingOrderPaymentOrderTableViewCell.h"

typedef NS_ENUM(NSInteger, VENMyBalanceRechargeStyle) {
    VENMyBalanceRechargeStyleWXPay,
    VENMyBalanceRechargeStyleAliPay
};
@interface VENMyBalanceRechargeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) VENMyBalanceRechargeStyle rechargeStyle;

@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *cellIdentifier2 = @"cellIdentifier2";
@implementation VENMyBalanceRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"充值";
    
    self.rechargeStyle = VENMyBalanceRechargeStyleWXPay;
    
    [self setupTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        VENMyBalanceRechargeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        return cell;
    } else {
        VENShoppingCartPlacingOrderPaymentOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftImageView.image = [UIImage imageNamed:indexPath.row == 0 ? @"icon_pay_01" : @"icon_pay_02"];
        cell.titleLabel.text = indexPath.row == 0 ? @"微信支付" : @"支付宝";

        cell.choiceButton.tag = indexPath.row;
        cell.choiceButton.selected = self.rechargeStyle == VENMyBalanceRechargeStyleWXPay ? indexPath.row == 0 ? YES : NO : indexPath.row == 0 ? NO : YES;
        [cell.choiceButton addTarget:self action:@selector(choiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}

- (void)choiceButtonClick:(UIButton *)button {
    self.rechargeStyle = button.tag == 0 ? VENMyBalanceRechargeStyleWXPay : VENMyBalanceRechargeStyleAliPay;
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 131 : 54;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENMyBalanceRechargeTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartPlacingOrderPaymentOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    [self.view addSubview:tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 48 + 31)];
    tableView.tableFooterView = footerView;
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 31, kMainScreenWidth - 30, 48)];
    [confirmButton setTitle:@"确定充值" forState:UIControlStateNormal];
    confirmButton.backgroundColor = UIColorFromRGB(0xC7974F);
    confirmButton.layer.cornerRadius = 4.0f;
    confirmButton.layer.masksToBounds = YES;
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmButton];
    
    _tableView = tableView;
}

- (void)confirmButtonClick {
    NSLog(@"确定充值");
    
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
