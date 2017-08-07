//
//  ZCLeftCell.m
//  xiaoDengTravel
//
//  Created by James on 16/12/26.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "ZCLeftCell.h"
#import "UIView+Extension.h"


@implementation ZCLeftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    self.color.backgroundColor = [UIColor blueColor];
    self.textLabel.highlightedTextColor = [UIColor colorWithRed:53/255.0f green:123/255.0f blue:240/255.0f alpha:1];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // 重新调整内部的textLable
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
}

// 在这个方法中 监听cell的选中和取消
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.color.hidden = !selected;
    self.textLabel.textColor = selected ?self.color.backgroundColor : [UIColor colorWithRed:78.0/255.0 green:78.0/255.0 blue:78.0/255.0 alpha:1];
}

@end
