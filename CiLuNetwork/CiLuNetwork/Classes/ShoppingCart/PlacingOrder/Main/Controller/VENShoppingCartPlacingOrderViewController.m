//
//  VENShoppingCartPlacingOrderViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/21.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartPlacingOrderViewController.h"
#import "VENShoppingCartTableViewCell.h"
#import "VENShoppingCartPlacingOrderHeaderView.h"
#import "VENShoppingCartPlacingOrderFooterView.h"
#import "VENShoppingCartPlacingOrderReceivingAddressViewController.h"
#import "VENShoppingCartPlacingOrderPaymentOrderViewController.h"
#import "VENShoppingCartModel.h"

@interface VENShoppingCartPlacingOrderViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *goods_listArr;
@property (nonatomic, strong) VENShoppingCartModel *goods_countModel;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENShoppingCartPlacingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"提交订单";
    
    [self loadData];
}

- (void)loadData {
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"order/preApply" params:nil showLoading:YES successBlock:^(id response) {
        
        NSArray *goods_listArr = [NSArray yy_modelArrayWithClass:[VENShoppingCartModel class] json:response[@"data"][@"goods_list"]];
        self.goods_listArr = goods_listArr;
        
        
        VENShoppingCartModel *goods_countModel = [VENShoppingCartModel yy_modelWithJSON:response[@"data"][@"goods_count"]];
        self.goods_countModel = goods_countModel;
        
        [self setupTableView];
        [self setupBottomToolBar];
        
    } failureBlock:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods_listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VENShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.priceLabel.textColor = UIColorFromRGB(0x1A1A1A);
    cell.iconImageViewLayoutConstraint.constant = -33.0f;
    cell.choiceButton.hidden = YES;
    
    VENShoppingCartModel *model = self.goods_listArr[indexPath.row];
    
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_thumb]];
    cell.titleLabel.text = model.goods_name;
    cell.otherLabel.text = [NSString stringWithFormat:@"规格：%@", model.spec];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", model.price];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)model.number];
    
    
    return cell;
}

- (void)setupBottomToolBar {
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - 48 - statusNavHeight, kMainScreenHeight, 48)];
    bottomToolBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomToolBar];
    
    UILabel *wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 48 / 2 - 17 / 2, kMainScreenWidth / 3 * 2 - 30, 17)];
    wordLabel.font = [UIFont systemFontOfSize:14.0f];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总计：%@", _goods_countModel.price_count_formatted]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xD0021B)} range:NSMakeRange(3, attributedString.length - 3)];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18.0f]} range:NSMakeRange(4, attributedString.length - 4)];
    wordLabel.attributedText = attributedString;
    wordLabel.textAlignment = NSTextAlignmentRight;
    [bottomToolBar addSubview:wordLabel];
    
    UIButton *commitButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth / 3 * 2, 0, kMainScreenWidth / 3, 48)];
    [commitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    commitButton.backgroundColor = COLOR_THEME;
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolBar addSubview:commitButton];
}

- (void)commitButtonClick {
    NSLog(@"提交订单");
    
    VENShoppingCartPlacingOrderPaymentOrderViewController *vc = [[VENShoppingCartPlacingOrderPaymentOrderViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - 48) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColorMake(245, 245, 245);
    [tableView registerNib:[UINib nibWithNibName:@"VENShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    
    /**
     + 添加收货地址
     */
    VENShoppingCartPlacingOrderHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"VENShoppingCartPlacingOrderHeaderView" owner:nil options:nil] lastObject];
    [headerView.addReceivingAddressButton addTarget:self action:@selector(addReceivingAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    tableView.tableHeaderView = headerView;
    
    /**
     共计*件商品      小计 ¥**
     支付方式
     留言备注
     */
    
    VENShoppingCartPlacingOrderFooterView *footerView = [[[NSBundle mainBundle] loadNibNamed:@"VENShoppingCartPlacingOrderFooterView" owner:nil options:nil] lastObject];
    
    footerView.totalLabel.text = [NSString stringWithFormat:@"共计%ld件商品", (long)_goods_countModel.number];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"小计 %@", _goods_countModel.price_count_formatted]];
    [attributedString addAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xD0021B), NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14.0f]} range:NSMakeRange(3, attributedString.length - 3)];
    footerView.totalPriceLabel.attributedText = attributedString;
    
    tableView.tableFooterView = footerView;
}

- (void)addReceivingAddressButtonClick {
    NSLog(@"添加收货地址");
    
    VENShoppingCartPlacingOrderReceivingAddressViewController *vc = [[VENShoppingCartPlacingOrderReceivingAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
