//
//  VENMyTeamSubviewsController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/27.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyTeamSubviewsController.h"
#import "VENMyTeamSubviewsTableViewCell.h"

@interface VENMyTeamSubviewsController () <UITableViewDelegate, UITableViewDataSource>

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENMyTeamSubviewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableView];
}

- (void)loadDataWithPage:(NSString *)page {
    
    NSDictionary *params = @{@"status" : @"2",
                             @"page" : page,
                             @"page_size" : @"20"};
    
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"order/lists" params:params showLoading:YES successBlock:^(id response) {
        [self.tableView.mj_header endRefreshing];
        
        if ([response[@"status"] integerValue] == 0) {
            
            if ([page integerValue] == 1) {
                
//                self.responseMuArr = [NSMutableArray arrayWithArray:response[@"data"][@"lists"]];
//                self.listsMuArr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:[VENMyOrderAllOrdersModel class] json:response[@"data"][@"lists"]]];
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                
//                [self.responseMuArr addObjectsFromArray:response[@"data"][@"lists"]];
//
//                [self.listsMuArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[VENMyOrderAllOrdersModel class] json:response[@"data"][@"lists"]]];
            }
            
            if ([response[@"data"][@"hasNext"] integerValue] == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            } else {
                [self.tableView.mj_footer endRefreshing];
            }
            
            [self.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        if ([page integerValue] == 1) {
            [self.tableView.mj_header endRefreshing];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENMyTeamSubviewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - tabBarHeight) style:UITableViewStylePlain];
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"VENMyTeamSubviewsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 10)];
    tableView.tableHeaderView = headerView;
    
    __block NSInteger page = 1;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataWithPage:@"1"];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadDataWithPage:[NSString stringWithFormat:@"%ld", ++page]];
    }];
    
    _tableView = tableView;
}

- (CGFloat)label:(UILabel *)label setWidthToHeight:(CGFloat)Height {
    CGSize size = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, Height)];
    return size.width;
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
