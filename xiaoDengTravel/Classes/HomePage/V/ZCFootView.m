//
//  ZCFootView.m
//  xiaoDengTravel
//
//  Created by James on 16/12/11.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCFootView.h"

@implementation ZCFootView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatFootView];
    }
    return self;
}

-(void)creatFootView {
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 1, Screen_Width, 26.0f);
    [self.button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self addSubview:self.button];
}

- (void)click:(UIButton *) button {
    [self.delegate sendButton:button];
    
}
@end
