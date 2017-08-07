//
//  RightModel.m
//  xiaoDengTravel
//
//  Created by James on 16/12/28.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//

#import "RightModel.h"


@implementation RightModel

+(NSDictionary *)mj_objectClassInArray {
    
    return @{@"data":@"DaModel"};
}

@end

@implementation DaModel

+(NSDictionary *)mj_objectClassInArray {
    return @{@"guides":@"GuidesModel"};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

@end

@implementation GuidesModel


@end
