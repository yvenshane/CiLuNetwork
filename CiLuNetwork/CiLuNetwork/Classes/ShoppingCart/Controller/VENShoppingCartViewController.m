//
//  VENShoppingCartViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/3.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartViewController.h"
#import "VENShoppingCartTableViewCell.h"

@interface VENShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSourceMuArr;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    
    if (self.dataSourceMuArr.count > 0) {
        [self setupShoppingBar];
        [self setupEditButton];
        [self setupTableView];
    } else {
        [self setupPlaceholderStatus];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 10 : 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == self.dataSourceMuArr.count - 1 ? 10 : 5;
}

- (void)editButtonClick {
    
}

- (void)setupEditButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - 44 - statusNavHeight - tabBarHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    tableView.rowHeight = 100;
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
}

- (void)setupShoppingBar {
    UIView *shoppingBar = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - statusNavHeight - 44 - 49, kMainScreenWidth, 44)];
    shoppingBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shoppingBar];
    
    UIButton *selectAllButton = [[UIButton alloc] initWithFrame:CGRectMake(-6, 0, 100, 44)];
    selectAllButton.backgroundColor = [UIColor whiteColor];
    [selectAllButton setImage:[UIImage imageNamed:@"icon_selecte_not"] forState:UIControlStateNormal];
    [selectAllButton setTitle:@"   全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [shoppingBar addSubview:selectAllButton];
    
    NSString *tempStr = @"56.00";
    
    UILabel *priceLabel = [[UILabel alloc] init];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：¥%@", tempStr]];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xD0021B) range:NSMakeRange(3, tempStr.length + 1)];
    priceLabel.attributedText = attributedStr;
    priceLabel.font = [UIFont systemFontOfSize:14.0f];
    CGFloat priceLabelWidth = [self label:priceLabel setWidthToHeight:20];
    priceLabel.frame = CGRectMake(kMainScreenWidth - 100 - 20 - priceLabelWidth, 44 / 2 - 20 / 2, priceLabelWidth, 20);
    [shoppingBar addSubview:priceLabel];

    UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 100, 0, 100, 44)];
    payButton.backgroundColor = UIColorFromRGB(0xCCCCCC);
    [payButton setTitle:@"结算(0)" forState:UIControlStateNormal];
    payButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [shoppingBar addSubview:payButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xE8E8E8);
    [shoppingBar addSubview:lineView];
}

- (void)setupPlaceholderStatus {
    
    CGFloat backgroundViewWidth = kMainScreenWidth - 64;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(32, (kMainScreenHeight - statusNavHeight - tabBarHeight) / 2 - (81 + 19 + 20 + 30 + 40) / 2, kMainScreenWidth - 64, 81 + 19 + 20 + 30 + 40)];
    [self.view addSubview:backgroundView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundViewWidth / 2 - 129 / 2, 0, 129, 81)];
    iconImageView.image = [UIImage imageNamed:@"icon_shopping_cart_empty"];
    [backgroundView addSubview:iconImageView];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"购物车是空的哦";
    messageLabel.textColor = UIColorFromRGB(0xB2B2B2);
    messageLabel.font = [UIFont systemFontOfSize:16.0f];
    CGFloat messageLabelWidth = [self label:messageLabel setWidthToHeight:20];
    messageLabel.frame = CGRectMake(backgroundViewWidth / 2 - messageLabelWidth / 2, 81 + 19, messageLabelWidth, 20);
    [backgroundView addSubview:messageLabel];
    
    UIButton *strollButton = [[UIButton alloc] initWithFrame:CGRectMake(backgroundViewWidth / 2 - 86 / 2, 81 + 19 + 20 + 30, 86, 40)];
    [strollButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    [strollButton setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    strollButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    strollButton.layer.borderWidth = 1;
    strollButton.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
    strollButton.layer.cornerRadius = 4;
    strollButton.layer.masksToBounds = YES;
    [backgroundView addSubview:strollButton];
}

- (CGFloat)label:(UILabel *)label setHeightToWidth:(CGFloat)width {
    CGSize size = [label sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    return size.height;
}

- (CGFloat)label:(UILabel *)label setWidthToHeight:(CGFloat)Height {
    CGSize size = [label sizeThatFits:CGSizeMake(CGFLOAT_MAX, Height)];
    return size.width;
}

- (NSMutableArray *)dataSourceMuArr {
    if (_dataSourceMuArr == nil) {
        _dataSourceMuArr = [NSMutableArray arrayWithArray:@[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"]];
//        _dataSourceMuArr = [NSMutableArray array];
    }
    return _dataSourceMuArr;
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
