//
//  ZCAuthorCell.m
//  xiaoDengTravel
//
//  Created by James on 17/1/5.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "ZCAuthorCell.h"
#import "SDAutoLayout.h"



@implementation ZCAuthorCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

-(void)loadView {
    CGFloat margin = 5.0f;
    _authorLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_authorLabel];
    // 标题设置位置
    _authorLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .heightIs(35.0f);
    
    _authorImg = [[UIImageView alloc]init];
    _authorImg.layer.cornerRadius = 5.0f;
    _authorImg.layer.masksToBounds = YES;
    [self.contentView addSubview:_authorImg];
    // 设置图片位置
    _authorImg.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(_authorLabel,0)
    .heightIs(50.0f)
    .widthIs(50.0f);
    
    _authorNameLabel = [[UILabel alloc]init];
    _authorNameLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_authorNameLabel];
    // 设置用户的位置
    _authorNameLabel.sd_layout
    .centerYEqualToView(_authorImg)
    .leftSpaceToView(_authorImg,3.0f)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    _authorIntroduceLabel = [[UILabel alloc]init];
    _authorIntroduceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_authorIntroduceLabel];
    // 设置简介的位置
    _authorIntroduceLabel.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .topSpaceToView(self.authorImg,3.0f)
    .rightSpaceToView(self.contentView,margin)
    .autoHeightRatio(0);
    
    //设置最后的view
//    [self setupAutoHeightWithBottomViewsArray:@[_authorIntroduceLabel] bottomMargin:margin];;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
