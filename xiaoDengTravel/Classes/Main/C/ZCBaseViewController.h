//
//  ZCBaseViewController.h
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCBaseViewController : UIViewController

// 设置标题
- (void)addTitleViewTitle:(NSString *)title;

// 设置左右按钮
-(void)addBarButtonItem:(NSString *)name image:(UIImage *)image target:(id)target action:(SEL)action isLeft:(Boolean)isLeft;

@end
