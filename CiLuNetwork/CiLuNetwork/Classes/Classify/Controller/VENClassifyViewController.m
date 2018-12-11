//
//  VENClassifyViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/3.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifyViewController.h"

@interface VENClassifyViewController ()  <JXCategoryViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation VENClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, kMainScreenWidth, kMainScreenHeight)];
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    
    //1、初始化JXCategoryTitleView
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 50)];
    self.categoryView.delegate = self;
    
    //2、添加并配置指示器
    //lineView
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor redColor];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    //backgroundView
    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewColor = [UIColor redColor];
    backgroundView.backgroundViewWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView, backgroundView];
    
    //3、绑定contentScrollView。self.scrollView的初始化细节参考源码。
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[[JXCategoryBaseView class] alloc] init];
    }
    return _categoryView;
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
