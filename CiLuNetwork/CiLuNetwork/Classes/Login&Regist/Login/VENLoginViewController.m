//
//  VENLoginViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/17.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENLoginViewController.h"
#import "VENVerificationOfPhoneNumberViewController.h"
#import "VENRegistViewController.h"

@interface VENLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordButton;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginButton;

@end

@implementation VENLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginButton.layer.cornerRadius = 4.0f;
    self.loginButton.layer.masksToBounds = YES;
    
    self.wxLoginButton.layer.cornerRadius = 4.0f;
    self.wxLoginButton.layer.masksToBounds = YES;
}

- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonClick:(id)sender {
    VENVerificationOfPhoneNumberViewController *vc = [[VENVerificationOfPhoneNumberViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)registButtonClick:(id)sender {
    VENRegistViewController *vc = [[VENRegistViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
