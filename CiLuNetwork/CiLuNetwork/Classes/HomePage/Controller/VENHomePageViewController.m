//
//  VENHomePageViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/3.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENHomePageViewController.h"
#import "VENHomePageNavigationItemTitleView.h"
#import "VENHomePageCollectionViewCell.h"
#import "VENHomePageHorizontalCollectionView.h"
#import "VENHomePageCollectionViewHeaderView.h"

@interface VENHomePageViewController () <SDCycleScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation VENHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationItemTitleView];
    [self setupNavigationItemLeftBarButtonItem];
    [self setupNavigationItemRightBarButtonItem];
    [self setupCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? 5 : 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VENHomePageCollectionViewCell *cell = (VENHomePageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? CGSizeMake(kMainScreenWidth, 327 - 10) : CGSizeMake(kMainScreenWidth, 62 - 10);
}

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat itemWidth = (kMainScreenWidth - 3 * 10) / 2;
    layout.itemSize = CGSizeMake(itemWidth, 248);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight - tabBarHeight) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VENHomePageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    [self.view addSubview:collectionView];
    
    // 广告
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainScreenWidth, 160) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = COLOR_THEME;
    cycleScrollView.pageDotColor = [UIColor whiteColor];
    cycleScrollView.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543947136429&di=325c21ef74d7e34d78a04d63de8dc54c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0106fd580ec6bda84a0d304f01333c.jpg"];
    cycleScrollView.autoScrollTimeInterval = 3;
    [collectionView addSubview:cycleScrollView];
    
    // 分类图标
    VENHomePageHorizontalCollectionView *horizontalCollectionView = [[VENHomePageHorizontalCollectionView alloc] initWithFrame:CGRectMake(0, 160, kMainScreenWidth, 105)];
    [collectionView addSubview:horizontalCollectionView];
    
    // 分割线 + 标题
    VENHomePageCollectionViewHeaderView *collectionViewHeaderView = [[VENHomePageCollectionViewHeaderView alloc] initWithFrame:CGRectMake(0, 265, kMainScreenWidth, 62)];
    collectionViewHeaderView.title = @"热门推荐";
    [collectionView addSubview:collectionViewHeaderView];
    
    // 分割线 + 标题
    VENHomePageCollectionViewHeaderView *collectionViewHeaderView2 = [[VENHomePageCollectionViewHeaderView alloc] initWithFrame:CGRectMake(0, 327 + 3 * 248 + 20 + 10, kMainScreenWidth, 62)];
    collectionViewHeaderView2.title = @"新品上架";
    [collectionView addSubview:collectionViewHeaderView2];
}

- (void)setupNavigationItemRightBarButtonItem {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setImage:[UIImage imageNamed:@"icon_search01"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)rightButtonClick {
    NSLog(@"右边");
}

- (void)setupNavigationItemLeftBarButtonItem {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    button.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [button setImage:[UIImage imageNamed:@"icon_class"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButton;
}

- (void)leftButtonClick {
    NSLog(@"左边");
}

- (void)setupNavigationItemTitleView {
    CGFloat titleViewWidth = 212.0f;
    
    VENHomePageNavigationItemTitleView *titleView = [[VENHomePageNavigationItemTitleView alloc] initWithFrame:CGRectMake(0, 0, titleViewWidth, 44)];
    titleView.titleViewWidth = titleViewWidth;
    titleView.buttonClickBlock = ^(NSString *str) {
        if ([str isEqualToString:@"left"]) {
            NSLog(@"正雷太极");
        } else if ([str isEqualToString:@"right"]) {
            NSLog(@"赐路赢");
        }
    };
    
    self.navigationItem.titleView = titleView;
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
