//
//  VENClassifyCollectionViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/14.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifyCollectionViewController.h"
#import "VENHomePageCollectionViewCell.h"
#import "VENClassifyDetailsViewController.h"
#import "VENClassifyModel.h"

@interface VENClassifyCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation VENClassifyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([VENHomePageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *tag = [[NSUserDefaults standardUserDefaults] objectForKey:@"tag"];
        if ([[VENClassEmptyManager sharedManager] isEmptyString:tag]) {
            tag = @"1";
        }
        
        NSDictionary *parmas = @{@"cate_id" : self.model.cate_id,
                                 @"tag" : tag};
        [self loadDataWith:parmas];
    }];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.collectionView.mj_header beginRefreshing];
    });
}

- (void)loadDataWith:(NSDictionary *)params {
    
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"goods/lists" params:params showLoading:YES successBlock:^(id response) {
        
        [self.collectionView.mj_header endRefreshing];
        
        if ([response[@"status"] integerValue] == 0) {
            
            VENClassifyModel *current_conditionsModel = [VENClassifyModel yy_modelWithJSON:response[@"data"][@"current_conditions"]];
            
            NSArray *lists_goods = [NSArray yy_modelArrayWithClass:[VENClassifyModel class] json:response[@"data"][@"lists"][@"goods"]];
            
            self.lists_goods = lists_goods;
            self.model = current_conditionsModel;
            
            [self.collectionView reloadData];
            
            // 解决点击首页分类按钮 分类页面第一次不跳转到指定页面 BUG
            if (![[VENClassEmptyManager sharedManager] isEmptyString:[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoading"]]) {
                
                self.block1([[[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoading"] integerValue]);
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FirstLoading"];
            }
        }
        
    } failureBlock:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lists_goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VENHomePageCollectionViewCell *cell = (VENHomePageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    VENClassifyModel *model = self.lists_goods[indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_thumb] placeholderImage:[UIImage imageNamed:@"1"]];
    cell.titleLabel.text = model.goods_name;
    cell.priceLabel.text= model.goods_price;
    cell.numberLabel.text= model.sale_status;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.block([NSString stringWithFormat:@"%ld", (long)indexPath.row]);
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
