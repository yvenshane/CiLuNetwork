//
//  VENFillInInformationViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2018/12/17.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENFillInInformationViewController.h"
#import "VENSetPasswordViewController.h"

@interface VENFillInInformationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *upDataButton;
@property (weak, nonatomic) IBOutlet UITextField *idNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation VENFillInInformationViewController

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
    VENSetPasswordViewController *vc = [[VENSetPasswordViewController alloc] init];
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
