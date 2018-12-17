//
//  VENClassifyViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/3.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifyViewController.h"
#import "JXCategoryView.h"
#import "VENFilterView.h"
#import "VENClassifySearchViewController.h"
#import "VENClassifyCollectionViewController.h"

@interface VENClassifyViewController () <JXCategoryViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <VENClassifyCollectionViewController *> *listVCArray;
@property (nonatomic, strong) JXCategoryListVCContainerView *listVCContainerView;

@end

@implementation VENClassifyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // nav 黑线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 24, kMainScreenWidth - 30, 30)];
    searchTextField.delegate = self;
    searchTextField.font = [UIFont systemFontOfSize:12.0f];
    searchTextField.backgroundColor = UIColorFromRGB(0xF1F1F1);
    searchTextField.placeholder = @"请输入关键词搜索";
    
    searchTextField.layer.cornerRadius = 4.0f;
    searchTextField.layer.masksToBounds = YES;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30 / 2 - 14 / 2, 14, 14)];
    imgView.image = [UIImage imageNamed:@"icon_search02"];
    [leftView addSubview:imgView];
    
    searchTextField.leftView = leftView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = searchTextField;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *titles = [self getRandomTitles];
    NSUInteger count = titles.count;
    CGFloat categoryViewHeight = 50;
    CGFloat width = kMainScreenWidth;
    CGFloat height = kMainScreenHeight - statusNavHeight - categoryViewHeight;
    
    self.listVCArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemWidth = (kMainScreenWidth - 3 * 10) / 2;
        layout.itemSize = CGSizeMake(itemWidth, 248);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        VENClassifyCollectionViewController *listVC = [[VENClassifyCollectionViewController alloc] initWithCollectionViewLayout:layout];
        listVC.view.frame = CGRectMake(i*width, 0, width, height - 36 - 50 + 9);
        [self.listVCArray addObject:listVC];
    }
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, -8, kMainScreenWidth, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = titles;
    self.categoryView.titleFont = [UIFont systemFontOfSize:12.0f];
    self.categoryView.titleSelectedColor =COLOR_THEME;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = COLOR_THEME;
    lineView.indicatorLineViewHeight = 2;
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight + 36 - 8,  width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < count; i ++) {
        VENClassifyCollectionViewController *listVC = self.listVCArray[i];
        [self.scrollView addSubview:listVC.view];
    }
    
    self.categoryView.contentScrollView = self.scrollView;

    VENFilterView *headerView = [[VENFilterView alloc] initWithFrame:CGRectMake(0, 42, kMainScreenWidth, 36)];
    [self.view addSubview:headerView];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    VENClassifySearchViewController *vc = [[VENClassifySearchViewController alloc] init];
    [self presentViewController:vc animated:NO completion:nil];
    
    return NO;
}

//这句代码必须加上
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // nav 黑线
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (NSArray <NSString *> *)getRandomTitles {
    NSMutableArray *titles = @[@"红烧螃蟹", @"麻辣龙虾", @"美味苹果", @"胡萝卜", @"清甜葡萄", @"美味西瓜", @"美味香蕉", @"香甜菠萝", @"麻辣干锅", @"剁椒鱼头", @"鸳鸯火锅"].mutableCopy;
    NSInteger randomMaxCount = arc4random()%6 + 5;
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < randomMaxCount; i++) {
        NSInteger randomIndex = arc4random()%titles.count;
        [resultArray addObject:titles[randomIndex]];
        [titles removeObjectAtIndex:randomIndex];
    }
    return resultArray;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryViewClick" object:[NSString stringWithFormat:@"%ld", (long)index]];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    
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
