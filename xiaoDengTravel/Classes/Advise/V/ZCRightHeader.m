//
//  ZCRightHeader.m
//  xiaoDengTravel
//
//  Created by James on 16/12/26.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCRightHeader.h"

@implementation ZCRightHeader

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self cteateHeadView];
        
    }
    return self;
}

-(void)cteateHeadView {
    
    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 29)];
    self.imageV.image = [UIImage imageNamed:@"bg_profile_passport_blue@2x"];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 29)];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageV];
    
}
@end
