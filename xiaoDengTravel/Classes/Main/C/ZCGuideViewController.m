//
//  ZCGuideViewController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCGuideViewController.h"
#import "CommonDefine.h"
#import "ZCAdView.h"

#import "ZCRootViewController.h"
#import "AppDelegate.h"

@interface ZCGuideViewController ()

@end

@implementation ZCGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 判断是否是第一次启动
    if ([self isFristStartApp]) {
        [self showGuide];
    } else {
        [self goMain];
    }
   
}

// 第一次进入的引导页
-(void)showGuide{
   __weak ZCGuideViewController *weakSelf = self;
    NSArray *array = @[@"guide_640_1136_01",@"guide_640_1136_02",@"guide_640_1136_03"];
    ZCAdView *adView = [[ZCAdView alloc]initWithArray:array andFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andBlock:^{
        [weakSelf goMain];
    }];
    [self.view addSubview:adView];
}

// 主页
-(void)goMain {
    ZCRootViewController *rootVc = [[ZCRootViewController alloc]init];
    AppDelegate *delete = [UIApplication sharedApplication].delegate; ;
    delete.window.rootViewController = rootVc;
    
}

// 判断是否是第一次启动程序
- (BOOL)isFristStartApp {
    // 获得单利
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 读取次数
    NSString *number = [userDefaults objectForKey:kAppFirstLoadKey];
    // 判断是否有值
    if (number != nil) {
        NSLog(@"____不是第一次启动");
        // 非首次启动
        NSInteger starNumber = [number integerValue];
        // 用上一次的次数+1
        NSString *str = [NSString stringWithFormat:@"%ld",++starNumber];
        // 存的是用户第一次启动的次数
        [userDefaults setObject:str forKey:kAppFirstLoadKey];
        [userDefaults synchronize];
        return false;
    } else {
        NSLog(@"第一次启动");
        // 不能取到值,则是第一次启动
        [userDefaults setObject:@"1" forKey:kAppFirstLoadKey];
        [userDefaults synchronize];
        return true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
