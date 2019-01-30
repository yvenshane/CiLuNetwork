//
//  VENAboutUsViewController.m
//  CiLuNetwork
//
//  Created by YVEN on 2019/1/29.
//  Copyright © 2019年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENAboutUsViewController.h"

@interface VENAboutUsViewController () <UITableViewDelegate, UIWebViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIWebView *webView;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation VENAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"关于我们";
    
    [self setupTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight - statusNavHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = headerView;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMainScreenWidth, 1)];
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    
    NSDictionary *metaData = [[NSUserDefaults standardUserDefaults] objectForKey:@"metaData"];
    
    [webView loadHTMLString:metaData[@"about_us"] baseURL:nil];
    [headerView addSubview:webView];
    
    self.tableView = tableView;
    self.headerView = headerView;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = [webView.scrollView contentSize].height;
    
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    webView.frame = newFrame;
    
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, kMainScreenWidth, webViewHeight + self.height);
    self.tableView.tableHeaderView = self.headerView;
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
