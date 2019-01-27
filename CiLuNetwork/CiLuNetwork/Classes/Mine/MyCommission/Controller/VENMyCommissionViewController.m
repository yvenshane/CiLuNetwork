//
//  VENMyCommissionViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/27.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyCommissionViewController.h"
#import "VENMyBalanceHeaderViewTableViewCell.h"
#import "VENMyBalanceTableViewCell.h"

#import "VENMyBalanceRechargeViewController.h"
#import "VENMyBalanceWithdrawViewController.h"

@interface VENMyCommissionViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *cellIdentifier2 = @"cellIdentifier2";
@implementation VENMyCommissionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // nav 黑线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // nav 黑线
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"佣金管理";
    
    [self setupTableView];
    
    [self loadData];
}

- (void)loadData {
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"home/commissions" params:nil showLoading:YES successBlock:^(id response) {
        
    } failureBlock:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        VENMyBalanceHeaderViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleLabel.text = @"当前佣金（元）";
        cell.leftButton.hidden = YES;
        cell.rightButton.hidden = YES;
        cell.middleButton.hidden = NO;

        
        return cell;
    } else {
        VENMyBalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 192 : 64;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENMyBalanceTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"VENMyBalanceHeaderViewTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier2];
    [self.view addSubview:tableView];
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
