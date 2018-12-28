//
//  VENMineViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/3.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMineViewController.h"
#import "VENMineTableViewCellStyleOne.h"
#import "VENMineTableViewCellStyleTwo.h"
#import "VENMineTableViewCellStyleThree.h"
#import "VENLoginViewController.h"

#import "VENMyOrderViewController.h"

@interface VENMineViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *cellIdentifier2 = @"cellIdentifier2";
static NSString *cellIdentifier3 = @"cellIdentifier3";
@implementation VENMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    [self setupSettingButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VENMineTableViewCellStyleThree *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3 forIndexPath:indexPath];
        cell.separatorInset = UIEdgeInsetsMake(0, kMainScreenWidth, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        VENMineTableViewCellStyleTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.waitingForShipmentButton addTarget:self action:@selector(waitingForShipmentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.waitingForReceivingButton addTarget:self action:@selector(waitingForReceivingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.waitingForEvaluationButton addTarget:self action:@selector(waitingForEvaluationButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    } else {
        VENMineTableViewCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                cell.leftLabel.text = @"我的余额";
                cell.rightLabel.hidden = NO;
                cell.rightLabel.text = @"0元";
            } else {
                cell.rightLabel.hidden = YES;
                
                if (indexPath.row == 1) {
                    cell.leftLabel.text = @"我的积分";
                } else if (indexPath.row == 2) {
                    cell.leftLabel.text = @"佣金管理";
                } else {
                    cell.leftLabel.text = @"我的团队";
                }
            }
        } else {
            cell.rightLabel.hidden = YES;
            
            if (indexPath.row == 0) {
                cell.leftLabel.text = @"地址管理";
            } else if (indexPath.row == 1) {
                cell.leftLabel.text = @"我的收藏";
            } else {
                cell.leftLabel.text = @"我的评价";
            }
        }
        
        
        return cell;
    }
}

- (void)waitingForShipmentButtonClick {
    NSLog(@"待发货");
    
    VENMyOrderViewController *vc = [[VENMyOrderViewController alloc] init];
    vc.pushIndexPath = 1;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)waitingForReceivingButtonClick {
    NSLog(@"待收货");
    
    VENMyOrderViewController *vc = [[VENMyOrderViewController alloc] init];
    vc.pushIndexPath = 2;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)waitingForEvaluationButtonClick {
    NSLog(@"待评价");
    
    VENMyOrderViewController *vc = [[VENMyOrderViewController alloc] init];
    vc.pushIndexPath = 3;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VENLoginViewController *vc = [[VENLoginViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    } else if (indexPath.section == 1) {
        NSLog(@"全部订单");
        
        VENMyOrderViewController *vc = [[VENMyOrderViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 102;
    } else if (indexPath.section == 1) {
        return 111;
    } else {
        return 48;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == 3 ? 10 : 5;
}

- (void)settingButtonClick {
    
}

- (void)setupSettingButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"icon_install"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - tabBarHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENMineTableViewCellStyleOne" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"VENMineTableViewCellStyleTwo" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    [tableView registerNib:[UINib nibWithNibName:@"VENMineTableViewCellStyleThree" bundle:nil] forCellReuseIdentifier:cellIdentifier3];
    [self.view addSubview:tableView];
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
