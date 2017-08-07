//
//  RightModel.h
//  xiaoDengTravel
//
//  Created by James on 16/12/28.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//  数据模型

#import <Foundation/Foundation.h>
#import "MJExtension.h"

// 声明两个数据模型
@class DaModel,GuidesModel;

@interface RightModel : NSObject

// 大数组
@property (nonatomic, strong) NSMutableArray *data;

@end

@interface DaModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *guides;

@end

@interface GuidesModel : NSObject

@property (nonatomic, copy) NSString *guide_id;
@property (nonatomic, copy) NSString *guide_cnname;
@property (nonatomic, copy) NSString *guide_enname;
@property (nonatomic, copy) NSString *guide_pinyin;
@property (nonatomic, copy) NSString *category_id;
@property (nonatomic, copy) NSString *category_title;
@property (nonatomic, copy) NSString *country_id;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_en;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, assign) NSInteger *download;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, copy) NSString *update_log;



@end
