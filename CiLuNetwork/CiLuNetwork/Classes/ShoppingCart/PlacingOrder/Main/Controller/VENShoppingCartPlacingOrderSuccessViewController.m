//
//  VENShoppingCartPlacingOrderSuccessViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/26.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENShoppingCartPlacingOrderSuccessViewController.h"

@interface VENShoppingCartPlacingOrderSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *viewOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *continueBuyButton;

@end

@implementation VENShoppingCartPlacingOrderSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"下单成功";
    
    self.viewOrderButton.layer.cornerRadius = 4.0f;
    self.viewOrderButton.layer.masksToBounds = YES;
    self.viewOrderButton.layer.borderWidth = 1.0f;
    self.viewOrderButton.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
    
    self.continueBuyButton.layer.cornerRadius = 4.0f;
    self.continueBuyButton.layer.masksToBounds = YES;
    self.continueBuyButton.layer.borderWidth = 1.0f;
    self.continueBuyButton.layer.borderColor = UIColorFromRGB(0xCCCCCC).CGColor;
    
    [self setupFinishButton];
}

- (void)setupFinishButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x1A1A1A) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)backButtonClick {
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index - 3)] animated:YES];
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
