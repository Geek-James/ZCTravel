//
//  ZCBaseViewController.m
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//  定义一个父控制器

#import "ZCBaseViewController.h"

@interface ZCBaseViewController ()

@end

@implementation ZCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)addTitleViewTitle:(NSString *)title {
    
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    // 设置导航栏的titleView
    self.navigationItem.titleView = titleView;
    // 设置字体
    titleView.font = [UIFont systemFontOfSize:20.0f];
    // 设置颜色
    titleView.textColor = [UIColor blackColor];
    // 设置文字居中
    titleView.textAlignment = NSTextAlignmentCenter;
    // 设置文本
    titleView.text = title;
    
}

-(void)addBarButtonItem:(NSString *)name image:(UIImage *)image target:(id)target action:(SEL)action isLeft:(Boolean)isLeft {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    // 设置按钮标题
    [button setTitle:name forState:UIControlStateNormal];
    // 设置按钮背景图
    [button setBackgroundImage:image forState:UIControlStateNormal];
    // 设置frame
    button.frame = CGRectMake(0, 0, 44.0f, 30.0f);
    
    // 判断是否放在左侧
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
        
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
