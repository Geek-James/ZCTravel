//
//  ZCIntroduceCell.m
//  xiaoDengTravel
//
//  Created by James on 17/1/5.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "ZCIntroduceCell.h"

@implementation ZCIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.text = @"锦囊简介";
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
