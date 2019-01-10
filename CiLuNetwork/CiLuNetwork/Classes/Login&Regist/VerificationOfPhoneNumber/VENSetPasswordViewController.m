//
//  VENSetPasswordViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/17.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENSetPasswordViewController.h"

@interface VENSetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *setPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

@property (nonatomic, assign) BOOL setPasswordTextFieldStatus;

@end

@implementation VENSetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"mobile - %@", self.mobile);
    NSLog(@"mobile - %@", self.face_image);
    NSLog(@"mobile - %@", self.id_card);
    NSLog(@"mobile - %@", self.invitation_code);
    
    [self.setPasswordTextField addTarget:self action:@selector(setPasswordTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setPasswordTextFieldChanged:(UITextField*)textField {
    self.setPasswordTextFieldStatus = textField.text.length >= 6 ? YES : NO;
    self.registButton.backgroundColor = self.setPasswordTextFieldStatus == YES ? COLOR_THEME : UIColorFromRGB(0xDEDEDE);
}

#pragma mark - 注册
- (IBAction)registerButtonClick:(id)sender {
    if ([[VENClassEmptyManager sharedManager] isEmptyString:self.setPasswordTextField.text] || self.setPasswordTextField.text.length < 6) {
        [[VENMBProgressHUDManager sharedManager] showText:@"请设置密码"];
        return;
    }
    
    NSDictionary *params = @{@"mobile" : self.mobile,
                             @"password" : self.setPasswordTextField.text,
                             @"tag" : self.leftButton.selected == YES ? @"1" : @"2",
                             @"face_image" : self.face_image,
                             @"id_card" : self.id_card,
                             @"invitation_code" : self.invitation_code};
    
    [[VENNetworkTool sharedManager] requestWithMethod:HTTPMethodPost path:@"auth/register" params:params showLoading:YES successBlock:^(id response) {
        
        if ([response[@"status"] integerValue] == 0) {
            [self.parentViewController.parentViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
}


- (IBAction)leftButtonClick:(UIButton *)button {
    self.rightButton.selected = NO;
    button.selected = YES;
}

- (IBAction)rightButtonClick:(UIButton *)button {
    self.leftButton.selected = NO;
    button.selected = YES;
}


- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
