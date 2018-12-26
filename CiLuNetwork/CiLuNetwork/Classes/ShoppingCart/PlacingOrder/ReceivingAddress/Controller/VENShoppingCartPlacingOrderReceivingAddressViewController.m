//
//  VENShoppingCartPlacingOrderReceivingAddressViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/24.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartPlacingOrderReceivingAddressViewController.h"
#import "VENShoppingCartPlacingOrderReceivingAddressTableViewCell.h"
#import "VENShoppingCartPlacingOrderAddReceivingAddressViewController.h"

@interface VENShoppingCartPlacingOrderReceivingAddressViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL isManage;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *navigationRightButton;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENShoppingCartPlacingOrderReceivingAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"收货地址";
    
    [self setupManageButton];
    [self setupTableView];
    [self setupAddReceivingAddressButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENShoppingCartPlacingOrderReceivingAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.leftLabel.hidden = indexPath.row == 0 ? NO : YES;
    cell.addressLabelLayoutConstraint.constant = indexPath.row == 0 ? 75 : 15;
    cell.defaultAddressButton.selected = indexPath.row == 0 ? YES : NO;
    
    cell.lineView.hidden = self.isManage ? NO : YES;
    cell.defaultAddressButton.hidden = self.isManage ? NO : YES;
    cell.editButton.hidden = self.isManage ? NO : YES;
    cell.deleteButton.hidden = self.isManage ? NO : YES;
    
    [cell.editButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)editButtonClick {
    NSLog(@"编辑");
    
    VENShoppingCartPlacingOrderAddReceivingAddressViewController *vc = [[VENShoppingCartPlacingOrderAddReceivingAddressViewController alloc] init];
    vc.isEdit = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)deleteButtonClick {
    NSLog(@"删除");
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isManage ? 134 : 79;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - 48) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartPlacingOrderReceivingAddressTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    _tableView = tableView;
}

- (void)setupAddReceivingAddressButton {
    UIButton *addReceivingAddressButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - statusNavHeight - 48, kMainScreenWidth, 48)];
    addReceivingAddressButton.backgroundColor = COLOR_THEME;
    [addReceivingAddressButton setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addReceivingAddressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addReceivingAddressButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [addReceivingAddressButton addTarget:self action:@selector(addReceivingAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addReceivingAddressButton];
}

- (void)addReceivingAddressButtonClick {
    VENShoppingCartPlacingOrderAddReceivingAddressViewController *vc = [[VENShoppingCartPlacingOrderAddReceivingAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupManageButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"管理" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button addTarget:self action:@selector(manageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    _navigationRightButton = button;
}

- (void)manageButtonClick {
    self.isManage = !self.isManage;
    
    [self.navigationRightButton setTitle:self.isManage ? @"完成" : @"管理" forState:UIControlStateNormal];
    self.navigationItem.title = self.isManage ? @"管理收货地址" : @"收货地址";
    [self.tableView reloadData];
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
