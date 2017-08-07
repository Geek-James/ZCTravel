//
//  ZCFootView.h
//  xiaoDengTravel
//
//  Created by James on 16/12/11.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol footViewDelegate <NSObject> // 代理方法

- (void)sendButton:(UIButton *)button;

@end

@interface ZCFootView : UICollectionReusableView

@property (nonatomic, assign)id<footViewDelegate>delegate;
@property (nonatomic, strong) UIButton *button;


@end
