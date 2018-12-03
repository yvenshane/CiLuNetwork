//
//  VENTabBarController.m
//  
//  Created by YVEN.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENTabBarController.h"
#import "VENNavigationController.h"

@interface VENTabBarController () <UITabBarControllerDelegate>

@end

@implementation VENTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *vc1 = [self loadChildViewControllerWithClassName:@"VENHomePageViewController" andTitle:@"首页" andImageName:@"ic_home"];
    UIViewController *vc2 = [self loadChildViewControllerWithClassName:@"VENClassifyViewController" andTitle:@"分类" andImageName:@"ic_home"];
    UIViewController *vc3 = [self loadChildViewControllerWithClassName:@"VENShoppingCartViewController" andTitle:@"购物车" andImageName:@"ic_culture"];
    UIViewController *vc4 = [self loadChildViewControllerWithClassName:@"VENMineViewController" andTitle:@"我的" andImageName:@"ic_user"];
    vc4.tabBarItem.tag = 3;
    
    self.viewControllers = @[vc1, vc2, vc3, vc4];
    
//    self.tabBar.tintColor = COLOR_THEME;
    //    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
}

- (UIViewController *)loadChildViewControllerWithClassName:(NSString *)className andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    // 把类名的字符串转成类的类型
    Class class = NSClassFromString(className);
    
    // 通过转换出来的类的类型来创建控制器
    UIViewController *vc = [class new];
    
    // 设置TabBar的文字
    vc.tabBarItem.title = title;
    
    NSString *normalImageName = [imageName stringByAppendingString:@"_nor"];
    // 设置默认状态的图片
    vc.tabBarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 拼接选中状态的图片
    NSString *selectedImageName = [imageName stringByAppendingString:@"_on"];
    // 设置选中图片
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建导航控制器
    VENNavigationController *nav = [[VENNavigationController alloc] initWithRootViewController:vc];
    
    return nav;
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
