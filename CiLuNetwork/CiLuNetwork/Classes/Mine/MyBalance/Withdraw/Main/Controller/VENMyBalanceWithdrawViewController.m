//
//  VENMyBalanceWithdrawViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/2.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyBalanceWithdrawViewController.h"
#import "VENMyBalanceWithdrawTableViewCell.h"
#import "VENMyBalanceWithdrawTableViewCell2.h"
#import "VENMyBalanceAddAccountViewController.h"

typedef NS_ENUM(NSInteger, VENMyBalanceWithdrawStyle) {
    VENMyBalanceWithdrawStyleAliPay,
    VENMyBalanceWithdrawStyleBankCard
};
@interface VENMyBalanceWithdrawViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) VENMyBalanceWithdrawStyle withdrawStyle;

@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *cellIdentifier2 = @"cellIdentifier2";
@implementation VENMyBalanceWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"提现";
    
    self.withdrawStyle = VENMyBalanceWithdrawStyleAliPay;
    
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
        VENMyBalanceWithdrawTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
        
        return cell;
    } else {
        VENMyBalanceWithdrawTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftLabel.text = indexPath.row == 0 ? @"支付宝" : @"银行卡";
        
        cell.choiceButton.tag = indexPath.row;
        cell.choiceButton.selected = self.withdrawStyle == VENMyBalanceWithdrawStyleAliPay ? indexPath.row == 0 ? YES : NO : indexPath.row == 0 ? NO : YES;
        [cell.choiceButton addTarget:self action:@selector(choiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

- (void)choiceButtonClick:(UIButton *)button {
    self.withdrawStyle = button.tag == 0 ? VENMyBalanceWithdrawStyleAliPay : VENMyBalanceWithdrawStyleBankCard;
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        VENMyBalanceAddAccountViewController *vc = [[VENMyBalanceAddAccountViewController alloc] init];
        vc.withdrawAccountStyle = indexPath.row == 0 ? VENMyBalanceWithdrawAccountStyleAliPay : VENMyBalanceWithdrawAccountStyleBankCard;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 88 + 90 : 54;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENMyBalanceWithdrawTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"VENMyBalanceWithdrawTableViewCell2" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    [self.view addSubview:tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 48 + 31 + 37)];
    tableView.tableFooterView = footerView;
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 31, kMainScreenWidth - 30, 48)];
    [confirmButton setTitle:@"确定提现" forState:UIControlStateNormal];
    confirmButton.backgroundColor = UIColorFromRGB(0xC7974F);
    confirmButton.layer.cornerRadius = 4.0f;
    confirmButton.layer.masksToBounds = YES;
    [confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmButton];
    
    UILabel *reminderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 31 + 48 + 20, kMainScreenWidth - 30, 17)];
    reminderLabel.text = @"线上提现线下打款，具体到账时间请耐心等待";
    reminderLabel.font = [UIFont systemFontOfSize:14.0f];
    reminderLabel.textColor = UIColorFromRGB(0x999999);
    [footerView addSubview:reminderLabel];
    
    _tableView = tableView;
}

- (void)confirmButtonClick {
    
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
