//
//  ZCTableHeadView.h
//  xiaoDengTravel
//
//  Created by James on 17/1/4.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdviseDetailHeadViewDelegate <NSObject>
/**
 *  声明代理方法
 *
 *  @param downLoadBtn 下载按钮的代理方法
 */
- (void)downloandSleeve:(UIButton *) downLoadBtn;

/**
 *  声明代理方法
 *
 *  @param leftBtn 返回按钮的代理方法
 */

- (void)leftBackBtn:(UIButton *) leftBtn;


@end

@interface ZCTableHeadView : UIView

@property (nonatomic, strong) UIImageView *headerImage;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *downloadBtn;
@property (nonatomic, strong) UIButton *leftBackBtn;
@property (nonatomic, assign) id<AdviseDetailHeadViewDelegate> delegate;


@end
