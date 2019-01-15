//
//  VENClassifyDetailsUserEvaluateViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/20.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifyDetailsUserEvaluateViewController.h"
#import "VENClassifyDetailsUserEvaluateTableViewCell.h"
#import "VENClassifyDetailsUserEvaluateModel.h"

@interface VENClassifyDetailsUserEvaluateViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *commentsArr;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENClassifyDetailsUserEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"用户评价";
    
    [self setupTableView];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadDataWith:(NSDictionary *)params {
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"goods/comments" params:params showLoading:YES successBlock:^(id response) {
        [self.tableView.mj_header endRefreshing];
        
        NSArray *commentsArr = [NSArray yy_modelArrayWithClass:[VENClassifyDetailsUserEvaluateModel class] json:response[@"data"][@"comments"]];
        self.commentsArr = commentsArr;
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENClassifyDetailsUserEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    VENClassifyDetailsUserEvaluateModel *model = self.commentsArr[indexPath.row];
    
    [cell.userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.userPhoneNumberLabel.text = model.name;
    cell.dateLabel.text = model.commented_at;
    cell.contentLabel.text = model.content;
    
    return cell;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"VENClassifyDetailsUserEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    tableView.estimatedRowHeight = 100;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSDictionary *parmas = @{@"cate_id" : self.goods_id,
                                 @"page" : @"1"};
        [self loadDataWith:parmas];
    }];
    
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    _tableView = tableView;
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
