//
//  ZCHeadView.m
//  xiaoDengTravel
//
//  Created by James on 16/12/11.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCHeadView.h"

@implementation ZCHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatHeadView];
    }
    return self;
}
-(void)creatHeadView
{
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 29)];
    self.imageV.image = [UIImage imageNamed:@"bg_profile_passport_blue@2x"];
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 29)];
    self.titleLable.font=[UIFont systemFontOfSize:18];
    self.titleLable.textColor=[UIColor blackColor];
    self.titleLable.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLable];
    [self addSubview:self.imageV];
}

@end
