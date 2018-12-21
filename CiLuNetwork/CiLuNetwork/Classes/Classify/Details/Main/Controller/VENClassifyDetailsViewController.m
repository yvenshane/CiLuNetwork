//
//  VENClassifyDetailsViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/19.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifyDetailsViewController.h"
#import "VENClassifyDetailsHeaderView.h"
#import "VENClassifyDetailsPopupView.h"
#import "VENClassifyDetailsToolBarView.h"
#import "VENClassifyDetailsUserEvaluateViewController.h"

@interface VENClassifyDetailsViewController () <UITableViewDelegate, SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) VENClassifyDetailsPopupView *popupView;

@end

@implementation VENClassifyDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTableView];
    [self setupBottomToolBar];
    [self setupNavigationBar];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.navigationBar.alpha = scrollView.contentOffset.y <= 0 ? 0 : scrollView.contentOffset.y / statusNavHeight;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, kMainScreenWidth, kMainScreenHeight - 48 + 20) style:UITableViewStylePlain];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1000)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    // 轮播图
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainScreenWidth, 375) delegate:self placeholderImage:nil];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:0.5];
    cycleScrollView.pageDotColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:0.2];
    cycleScrollView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg"];
    cycleScrollView.autoScrollTimeInterval = 3;
    [headerView addSubview:cycleScrollView];
    
    // 返回
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"icon_back02"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

    // 收藏
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 45, 25, 30, 30)];
    [collectionButton setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectionButton];
    
    // headerView
    VENClassifyDetailsHeaderView *detailsHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"VENClassifyDetailsHeaderView" owner:nil options:nil] lastObject];
    detailsHeaderView.frame = CGRectMake(0, 375, kMainScreenWidth, 369);
    [detailsHeaderView.choiceButton addTarget:self action:@selector(choiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [detailsHeaderView.evaluateButton addTarget:self action:@selector(evaluateButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:detailsHeaderView];
    
    tableView.tableHeaderView = headerView;
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionButtonClick {
    NSLog(@"收藏");
}

- (void)choiceButtonClick {
    NSLog(@"选择规格");
}

- (void)evaluateButtonClick {
    NSLog(@"用户评价");
    
    VENClassifyDetailsUserEvaluateViewController *vc = [[VENClassifyDetailsUserEvaluateViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupBottomToolBar {
    VENClassifyDetailsToolBarView *bottomToolBarView = [[VENClassifyDetailsToolBarView alloc] initWithFrame:CGRectMake(0, kMainScreenHeight - 48, kMainScreenWidth, 48)];
    [self.view addSubview:bottomToolBarView];
    
    [bottomToolBarView.customerServiceButton addTarget:self action:@selector(customerServiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolBarView.shoppingCartButton addTarget:self action:@selector(shoppingCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolBarView.addShoppingCartButton addTarget:self action:@selector(addShoppingCartButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolBarView.purchaseButton addTarget:self action:@selector(purchaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customerServiceButtonClick {
    NSLog(@"客服");
}

- (void)shoppingCartButtonClick {
    NSLog(@"购物车");
}

- (void)addShoppingCartButtonClick {
    NSLog(@"加入购物车");
}

- (void)purchaseButtonClick {
    NSLog(@"立即购买");
    [self backgroundView];
    [self popupView];
}

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        [[UIApplication sharedApplication].keyWindow addSubview:_backgroundView];
    }
    return _backgroundView;
}

- (VENClassifyDetailsPopupView *)popupView {
    if (_popupView == nil) {
        __weak typeof(self) weakSelf = self;
        
        _popupView = [[VENClassifyDetailsPopupView alloc] init];
        _popupView.backgroundColor = [UIColor whiteColor];
        _popupView.transform = CGAffineTransformMakeTranslation(0.01, kMainScreenHeight);
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.popupView.transform = CGAffineTransformMakeTranslation(0.01, 0.01);
            weakSelf.popupView.backgroundColor = [UIColor whiteColor];
            weakSelf.popupView.frame = CGRectMake(0, kMainScreenHeight - 341, kMainScreenWidth, 341);
        }];
        
        // popupView 关闭按钮
        _popupView.block = ^(NSString *str) {
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.popupView.transform = CGAffineTransformMakeTranslation(0.01, kMainScreenHeight);
            }];
            [weakSelf.popupView removeFromSuperview];
            [weakSelf.backgroundView removeFromSuperview];
            weakSelf.backgroundView = nil;
            weakSelf.popupView = nil;
        };
        
        [_backgroundView addSubview:_popupView];
    }
    return _popupView;
}

- (void)setupNavigationBar {
    // navigationBar
    UIView *navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, statusNavHeight)];
    navigationBar.backgroundColor = [UIColor whiteColor];
    navigationBar.alpha = 0;
    [self.view addSubview:navigationBar];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 20, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:backButton];
    
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 8 - 44, 20, 44, 44)];
    [collectionButton setImage:[UIImage imageNamed:@"icon_collection02"] forState:UIControlStateNormal];
    [collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:collectionButton];
    
    _navigationBar = navigationBar;
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
