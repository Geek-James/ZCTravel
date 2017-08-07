//
//  AdviseDetailModel.h
//  xiaoDengTravel
//
//  Created by James on 17/1/4.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DataInfoModel,MobileModel,AuthorsModel,RelateModel;

/**
 *  AdviseDetailModel
 */
@interface AdviseDetailModel : NSObject

@property (nonatomic, strong) DataInfoModel *data;

@end

/**
 *  DataInfoModel
 */
@interface DataInfoModel : NSObject

@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, strong) MobileModel *mobile;
@property (nonatomic, strong) NSMutableArray *authors;
@property (nonatomic, strong) NSMutableArray *related_guides;
@property (nonatomic, assign) NSInteger country_id;
@property (nonatomic, assign) NSInteger download;
@end

/**
 *  MobileModel
 */
@interface MobileModel : NSObject

@property (nonatomic, copy) NSString *file;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger page;
@end

/**
 *  AuthorsModel
 */
@interface AuthorsModel : NSObject
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *intro;
@end

/**
 *  RelateModel
 */
@interface RelateModel : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *cnname;
@property (nonatomic, copy) NSString *enname;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *category_title;
@property (nonatomic, copy) NSString *country_name_cn;
@property (nonatomic, copy) NSString *country_name_en;
@property (nonatomic, copy) NSString *country_name_py;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *update_time;
@property (nonatomic, copy) NSString *cover_updatetime;
@property (nonatomic, assign) NSInteger download;
@property (nonatomic, assign) NSInteger country_id;
@end



