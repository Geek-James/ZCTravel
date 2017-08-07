//
//  AdviseDetailModel.m
//  xiaoDengTravel
//
//  Created by James on 17/1/4.
//  Copyright © 2017年 ZhangCong. All rights reserved.
//

#import "AdviseDetailModel.h"
#import "MJExtension.h"

@implementation AdviseDetailModel

+(NSDictionary *)mj_objectClassInArray {
    return @{@"data":@"DataInfoModel"};
}
@end

/**
 *   DataInfoModel
 */
@implementation DataInfoModel

+(NSDictionary *)mj_objectClassInArray {
    return @{@"mobile":@"MobileModel",
             @"authors":@"AuthorsModel",
             @"related_guides":@"RelateModel"};
}

@end

/**
 *  MobileModel
 */
@implementation MobileModel

@end

/**
 *  AuthorsModel
 */
@implementation AuthorsModel

@end

/**
 *  RelateModel
 */
@implementation RelateModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
@end
