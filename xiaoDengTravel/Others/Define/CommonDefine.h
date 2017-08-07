//
//  CommonDefine.h
//  xiaoDengTravel
//
//  Created by James on 16/12/3.
//  Copyright © 2016年 ZhangCong. All rights reserved.
//


#define CommonDefine_h

#ifndef LoveLimitFree_CommonDefin_h
#define LoveLimitFree_CommonDefin_h

/**
 *  当前的App版本
 */
#define kAppVersion (1.0)


/**
 *  当前系统版本
 */
#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])


/**
 *  当前屏幕大小
 */
#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

/**
 *  第一次启动App的Key
 */
#define kAppFirstLoadKey @"kAppFirstLoadKey"

/**
 *  调试模式的标签
 */
#define DEBUG_FLAG

/**
 *  如果是调试模式，QFLog就和NSLog一样，如果不是调试模式，QFLog就什么都不做
 *  __VA_ARGS__ 表示见面...的参数列表
 */
#ifdef DEBUG_FLAG
#define QFLog(fmt, ...) NSLog(fmt, __VA_ARGS__)
#else
#define QFLog(fmt, ...)
#endif


#endif
