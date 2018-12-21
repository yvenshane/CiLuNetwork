//
//  VENClassifySearchViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/11.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENClassifySearchViewController.h"

@interface VENClassifySearchViewController ()

@end

@implementation VENClassifySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 27, kMainScreenWidth - 30 - 15 - 32, 30)];
//    searchTextField.delegate = self;
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
    
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    searchTextField.autocorrectionType = UITextAutocorrectionTypeDefault;
    searchTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [self.view addSubview:searchTextField];
    
    [searchTextField becomeFirstResponder];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth - 15 - 32, 27 + 30 / 2 - 20 / 2, 32, 20)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)cancelButtonClick {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
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
