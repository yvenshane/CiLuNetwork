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
    self.block([NSString stringWithFormat:@"%@", indexPath]);
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
