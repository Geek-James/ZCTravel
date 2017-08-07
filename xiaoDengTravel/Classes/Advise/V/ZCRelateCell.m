//
//  ZCRelateCell.m
//  xiaoDengTravel
//
//  Created by James on 17/1/6.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "ZCRelateCell.h"
#import "SDAutoLayout.h"

@implementation ZCRelateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self reloadView];
    }
    return self;
}

-(void)reloadView {
    
    _relateImage = [[UIImageView alloc]init];
    _relateImage.layer.cornerRadius = 5.0f;
    _relateImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_relateImage];
    _relateImage.sd_layout
    .topSpaceToView(self.contentView,5.0f)
    .leftSpaceToView(self.contentView,10.0f)
    .widthIs(100.0f)
    .heightIs(140.0f);
    
    _relateTitle = [[UILabel alloc]init];
    _relateTitle.textColor = [UIColor blueColor];
    [self.contentView addSubview:_relateTitle];
    _relateTitle.sd_layout
    .leftSpaceToView(_relateImage,5.0f)
    .topEqualToView(_relateImage)
    .heightIs(35.0f)
    .rightSpaceToView(self.contentView,40.0f);
    
    _relateType = [[UILabel alloc]init];
    _relateType.textColor = [UIColor greenColor];
    [self.contentView addSubview:_relateType];
    _relateType.sd_layout
    .leftEqualToView(_relateTitle)
    .centerYEqualToView(_relateImage)
    .rightSpaceToView(self.contentView,30.0f)
    .heightIs(35.0f);
    
    _relateDownloadNum = [[UILabel alloc]init];
    _relateDownloadNum.textColor = [UIColor redColor];
    [self.contentView addSubview:_relateDownloadNum];
    _relateDownloadNum.sd_layout
    .bottomEqualToView(_relateImage)
    .heightIs(35.0f)
    .leftEqualToView(_relateType);
    
    _relateUpdate = [[UILabel alloc]init];
    [self.contentView addSubview:_relateUpdate];
    _relateUpdate.sd_layout
    .rightSpaceToView(self.contentView,5.0f)
    .bottomEqualToView(_relateImage)
    .leftSpaceToView(_relateDownloadNum,50.0f)
    .heightIs(35.0f);
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
