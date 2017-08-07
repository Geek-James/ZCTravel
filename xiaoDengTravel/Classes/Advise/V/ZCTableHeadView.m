//
//  ZCTableHeadView.m
//  xiaoDengTravel
//
//  Created by James on 17/1/4.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "ZCTableHeadView.h"
#import "UIImageView+WebCache.h"


@implementation ZCTableHeadView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatSubviews];
        self.frame = CGRectMake(0, 0, Screen_Width, 250);
    }
    return self;
}

-(void)creatSubviews {
    
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 250)];
    self.headerImage.userInteractionEnabled = true;
    [self addSubview:self.headerImage];
    
    self.headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 230, 100, 20)];
    [self addSubview:self.headLabel];
    
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadBtn.frame = CGRectMake(self.frame.size.width-80, self.frame.size.height-80, 80,80);
    [self.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadBtn setImage:[UIImage imageNamed:@"icon_trip_download@3x"] forState:UIControlStateNormal];
    [self.downloadBtn setImage:[UIImage imageNamed:@"icon_trip_download_pause@3x"] forState:UIControlStateSelected];
    self.downloadBtn.selected = false;
    self.downloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.headerImage addSubview:self.downloadBtn];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height+5, 90, 50)];
    // 设置默认进度
    self.progressView.progress = 0;
    self.progressView.hidden = true;
    [self.headerImage addSubview:self.progressView];
    
    self.leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBackBtn.frame = CGRectMake(10, 10, 50, 50);
    [self.leftBackBtn setImage:[UIImage imageNamed:@"login_close_icon@3x"] forState:UIControlStateNormal];
    [self.leftBackBtn addTarget:self action:@selector(leftBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerImage addSubview:self.leftBackBtn];
}

#pragma mark 创建代理
- (void)download:(UIButton *)downLoadBtn {
    
    if ([_delegate respondsToSelector:@selector(downloandSleeve:)]) {
        [_delegate downloandSleeve:downLoadBtn];
    }
}

- (void)leftBack:(UIButton *)leftBtn {
    if ([_delegate respondsToSelector:@selector(leftBackBtn:)]) {
        [_delegate leftBackBtn:leftBtn];
    }
}


@end
