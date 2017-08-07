//
//  ZCIntroduceCell.h
//  xiaoDengTravel
//
//  Created by James on 17/1/5.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdviseDetailModel.h"

@interface ZCIntroduceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, strong) AdviseDetailModel *model;
@end
