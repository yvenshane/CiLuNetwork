//
//  VENMyCollectionViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/27.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENMyCollectionViewController.h"
#import "VENShoppingCartTableViewCell.h"
#import "VENShoppingCartModel.h"

@interface VENMyCollectionViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *navigationRightButton;
@property (nonatomic, assign) BOOL isManage;

@property (nonatomic, strong) UIView *shoppingBar;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, strong) UIButton *selectAllButton;
@property (nonatomic, assign) BOOL isSelectAll;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    [self setupManagementCollectionButton];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    VENShoppingCartModel *model = self.listMuArr[indexPath.section];
    
    VENShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.iconImageViewLayoutConstraint.constant = self.isManage ? 0 : -33.0f;
    cell.choiceButton.hidden = self.isManage ? NO : YES;
    
    cell.priceLabel.hidden = YES;
    cell.numberLabel.hidden = YES;
    cell.otherLabel.textColor = UIColorFromRGB(0x1A1A1A);
    cell.lineImageView.hidden = NO;
    
    cell.iconImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
//
//    cell.titleLabel.hidden = self.isEdit ? YES : NO;
//    cell.numberLabel.hidden = self.isEdit ? YES : NO;
//    cell.titleLabel.text = model.goods_name;
//    cell.numberLabel.text = [NSString stringWithFormat:@"x%ld", (long)model.number];
//
//    cell.plusButton.hidden = self.isEdit ? NO : YES;
//    cell.plusButton.tag = 998 + indexPath.section;
//    [cell.plusButton addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    cell.minusButton.hidden = self.isEdit ? NO : YES;
//    cell.minusButton.tag = 998 + indexPath.section;
//    [cell.minusButton addTarget:self action:@selector(minusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    cell.deleteButton.hidden = self.isEdit ? NO : YES;
//    cell.deleteButton.tag = 998 + indexPath.section;
//    [cell.deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    cell.numberButton.hidden = self.isEdit ? NO : YES;
//    [cell.numberButton setTitle:[NSString stringWithFormat:@"%ld", (long)model.number] forState:normal];
//
//    cell.otherLabel.text = [NSString stringWithFormat:@"规格：%@", model.spec];
//    cell.priceLabel.text = model.price_formatted;
//
//    cell.choiceButton.tag = 998 + indexPath.section;
//    [cell.choiceButton addTarget:self action:@selector(choiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.choiceButton.selected = model.isChoice == YES ? YES : NO;
//
//    if (indexPath.section == 0) {
//        [self.choiceButtonsMuArr removeAllObjects];
//        [self.numberButtonsMuArr removeAllObjects];
//    }
//
//    [self.choiceButtonsMuArr addObject:cell.choiceButton];
//    [self.numberButtonsMuArr addObject:cell.numberButton];
    
    return cell;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.rowHeight = 100;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self loadDta];
    }];
    
    //    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //
    //    }];
    
    _tableView = tableView;
}

#pragma mark - 底部 toolBar
- (void)setupShoppingBar {
    UIView *shoppingBar = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - statusNavHeight - 44, kMainScreenWidth, 44)];
    shoppingBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shoppingBar];
    
    UIButton *selectAllButton = [[UIButton alloc] initWithFrame:CGRectMake(-6, 0, 100, 44)];
    selectAllButton.backgroundColor = [UIColor whiteColor];
    [selectAllButton setImage:[UIImage imageNamed:@"icon_selecte_not"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"icon_selecte"] forState:UIControlStateSelected];
    [selectAllButton setTitle:@"   全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//    [selectAllButton addTarget:self action:@selector(selectAllButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shoppingBar addSubview:selectAllButton];
    
    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 100, 0, 100, 44)];
    payButton.backgroundColor = UIColorFromRGB(0xCCCCCC);
    [payButton setTitle:@"删除" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
//    [payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [shoppingBar addSubview:payButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [shoppingBar addSubview:lineView];
    
    _shoppingBar = shoppingBar;
    _payButton = payButton;
    _selectAllButton = selectAllButton;
}

#pragma mark - 管理收藏
- (void)setupManagementCollectionButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
    [button setTitle:@"管理收藏" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button addTarget:self action:@selector(managementCollectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    _navigationRightButton = button;
}

- (void)managementCollectionButtonClick {
    self.isManage = self.isManage == YES ? NO : YES;
    [self.navigationRightButton setTitle:self.isManage ? @"完成" : @"管理收藏" forState:UIControlStateNormal];

    self.tableView.frame = CGRectMake(0, 0, kMainScreenWidth, self.isManage ? kMainScreenHeight - statusNavHeight - 44: kMainScreenHeight - statusNavHeight);
    
    [_shoppingBar removeFromSuperview];
    _shoppingBar = nil;
    if (self.isManage) {
        [self setupShoppingBar];
    }
    

    
    [self.tableView reloadData];
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
