//
//  VENRegistViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/17.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENRegistViewController.h"
#import "VENRegistSetPasswordViewController.h"

@interface VENRegistViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *invitationCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getverificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation VENRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nextButton.layer.cornerRadius = 4.0f;
    self.nextButton.layer.masksToBounds = YES;
}

- (IBAction)closeButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonClick:(id)sender {
    VENRegistSetPasswordViewController *vc = [[VENRegistSetPasswordViewController alloc] init];
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
