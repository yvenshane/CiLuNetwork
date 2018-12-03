//
//  VENNetworkTool.m
//
//  Created by YVEN.
//  Copyright © 2018年 Hefei Haiba Network Technology Co., Ltd. All rights reserved.
//

#import "VENNetworkTool.h"

@implementation VENNetworkTool

static VENNetworkTool *instance;
static dispatch_once_t onceToken;

+ (instancetype)sharedManager {
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://yidao.ahaiba.com.cn/api/index.php/"];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 15;
        instance = [[self alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];

//        [instance.requestSerializer setValue:[[VENUserTypeManager sharedManager] isLogin] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"Login"][@"apiKey"] : [[VENUserTypeManager sharedManager] isMaster] ? @"master_ios_lower_key" : @"user_ios_lower_key" forHTTPHeaderField:@"X-API-KEY"];
//
//        NSLog(@"%d", [[VENUserTypeManager sharedManager] isMaster]);
//
//        NSLog(@"X-API-KEY - %@", [[VENUserTypeManager sharedManager] isLogin] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"Login"][@"apiKey"] : @"user_ios_lower_key");
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    });
    return instance;
}

@end
