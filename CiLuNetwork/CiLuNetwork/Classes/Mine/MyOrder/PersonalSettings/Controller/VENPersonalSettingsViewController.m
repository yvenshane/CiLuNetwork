//
//  VENPersonalSettingsViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/15.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENPersonalSettingsViewController.h"
#import "VENMineTableViewCellStyleOne.h"

@interface VENPersonalSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENPersonalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人设置";
    
    [self setupTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENMineTableViewCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"VENMineTableViewCellStyleOne" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 48 + 18)];
    tableView.tableFooterView = footerView;
    
    UIButton *loginoutButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 18, kMainScreenWidth - 30, 48)];
    loginoutButton.backgroundColor = [UIColor whiteColor];
    [loginoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginoutButton setTitleColor:UIColorFromRGB(0xD0021B) forState:UIControlStateNormal];
    [loginoutButton addTarget:self action:@selector(loginoutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    loginoutButton.layer.cornerRadius = 4.0f;
    loginoutButton.layer.masksToBounds = YES;
    loginoutButton.layer.borderWidth = 1.0f;
    loginoutButton.layer.borderColor = UIColorFromRGB(0xD0021B).CGColor;
    [footerView addSubview:loginoutButton];
}

- (void)loginoutButtonClick {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"token"];
    
    [self.navigationController popViewControllerAnimated:YES];
    self.block(@"loginoutSuccess");
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