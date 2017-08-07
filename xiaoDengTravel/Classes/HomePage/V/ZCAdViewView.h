//
//  ZCAdViewView.h
//  xiaoDengTravel
//
//  Created by James on 16/12/11.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 创建代理
@protocol adViewViewDelegate <NSObject>

-(void)sendAdButton:(UIButton *) button;

@end

@interface ZCAdViewView : UICollectionReusableView<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, weak)id<adViewViewDelegate>delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSMutableArray *array;

@end
