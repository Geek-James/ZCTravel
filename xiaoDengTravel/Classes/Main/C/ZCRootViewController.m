//
//  ZCRootViewController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCRootViewController.h"
#import "ZCBaseNavigationController.h"


@interface ZCRootViewController ()

@end

@implementation ZCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewControllers];
    
}

-(void)creatViewControllers {
    
    // 每个TabbarItem对应的控制器
    NSArray *vcNameArray = @[@"ZCHomePageViewController",@"ZCDistinationViewController",@"ZCCommunityViewController",@"ZCMyViewController"];
    
    NSArray *nameArray = @[@"Sidebar-index@2x",@"Sidebar-map@2x",@"Sidebar-photo-stream@2x",@"Sidebar-mine@2x"];
    
    NSArray *clickNameArray = @[@"Sidebar-index-hold@2x",@"Sidebar-map-hold@2x",@"Sidebar-photo-stream-hold@2x",@"Sidebar-mine-hold@2x"];
    
     NSArray *titleArray = @[@"首页",@"目的地",@"游行",@"我的"];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i<vcNameArray.count; i++) {
        
        NSString *vcName = [vcNameArray objectAtIndex:i];
        Class vcClass = NSClassFromString(vcName);
        UIViewController *vc = [[vcClass alloc]init];
        ZCBaseNavigationController *nav = [[ZCBaseNavigationController alloc]initWithRootViewController:vc];
        [arrayM addObject:nav];
        
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:[UIImage imageNamed:nameArray[i]] selectedImage:[UIImage imageNamed:clickNameArray[i]]];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:53.0f/255.0f green:123.0f/255.0f blue:240.0f/255.0f alpha:1],NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f]} forState:UIControlStateSelected];
    }
    // 设置tabbar半透明为false
    self.tabBar.translucent = false;
    // 改变Tabbar的下面一样的颜色
    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"zu"]];
    self.viewControllers = arrayM;
    // 设置默认选择为第一个item
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
