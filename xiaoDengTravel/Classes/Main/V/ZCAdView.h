//
//  ZCAdView.h
//  xiaoDengTravel
//
//  Created by James on 16/12/4.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 初始化的时候 传过来一个存有图片的数组,必须使用initWithArray这个方法初始化
typedef void (^GoBackBlock)();

@interface ZCAdView : UIView

@property (nonatomic,strong) NSArray *imageArray;
- (id)initWithArray:(NSArray *)array andFrame:(CGRect)frame andBlock:(GoBackBlock)back;


@end
