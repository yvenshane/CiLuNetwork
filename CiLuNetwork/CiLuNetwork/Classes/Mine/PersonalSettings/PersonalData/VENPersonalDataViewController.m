//
//  VENPersonalDataViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/28.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENPersonalDataViewController.h"
#import "VENMineTableViewCellStyleOne.h"
#import "VENPersonalDataNamePageViewController.h"

@interface VENPersonalDataViewController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENPersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人资料";
    
    [self setupTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 3 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENMineTableViewCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *titleArr = @[@[@"头像", @"姓名", @"手机号码"], @[@"邀请码", @"我的邀请码"]];
    cell.leftLabel.text = titleArr[indexPath.section][indexPath.row];
    
    cell.iconImageView.hidden = YES;
    cell.rightLabel.hidden = YES;
    cell.rightButton.hidden = YES;
    cell.rightLabel2.hidden = YES;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.iconImageView.hidden = NO;
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"icon_default_head_big"]];
        } else if (indexPath.row == 1){
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"姓名姓名姓名";
            cell.rightLabel.textColor = UIColorFromRGB(0x1A1A1A);
        } else {
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = @"13333333333";
            cell.rightLabel.textColor = UIColorFromRGB(0xCCCCCC);
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            cell.rightButton.hidden = NO;
            cell.rightLabel2.hidden = NO;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            VENPersonalDataNamePageViewController *vc = [[VENPersonalDataNamePageViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 60;
        }
    }
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 10 : 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"VENMineTableViewCellStyleOne" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
