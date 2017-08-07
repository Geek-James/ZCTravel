//
//  ZCBaseNavigationController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCBaseNavigationController.h"
#import "UIView+Extension.h"


@interface ZCBaseNavigationController ()

@end

@implementation ZCBaseNavigationController

+(void)initialize {
    // 获得navigationBar的所有属性
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"houses@2x"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f]}];
    
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // stateNormal
    NSMutableDictionary *itemsDic = [NSMutableDictionary dictionary];
    itemsDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemsDic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0f];
    [item setTitleTextAttributes:itemsDic forState:UIControlStateNormal];
    
    //UIControlStateDisabled
    NSMutableDictionary *itemDisabled = [NSMutableDictionary dictionary];
    itemDisabled[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabled forState:UIControlStateDisabled];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 如果滑动移除控制器的功能失效,清空代理(当导航控制器重新设置这个功能)
    self.interactivePopGestureRecognizer.delegate = nil;
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        // 如果push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn@2x"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick@2x"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70.0f, 30.0f);
        // 让按钮内部内容往左偏移10
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button  addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
        // 这句super的push要放到后面,让viewController可以覆盖上面设置的leftBarButton
    [super pushViewController:viewController animated:YES];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
