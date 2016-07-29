//
//  BWColor.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** RGB颜色 */
#define BWColorRGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define BWColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/** HEX颜色 */
#define BWColorHex(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:1.0]
#define BWColorHexA(c,a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0 alpha:(a)]

@interface BWColor : NSObject

/**
 * 16进制
 */
+ (UIColor *)colorFromHex:(NSString *)hexValue alpha:(CGFloat)alpha;

/**
 *  默认背景颜色，一些浅色背景色（右滑背景，设置页面的一些背景图）
 */
+ (UIColor *)defaultBackgroundColor;

/**
 *  导航栏背景颜色
 */
+ (UIColor *)navigationBarBackgroundColor;

/**
 *  导航栏标题颜色，用于重要级文字，内页标题信息
 */
+ (UIColor *)navigationBarTitleColor;

/**
 *  标题文本颜色，颜色同navigationBarTitleColor，导航栏标题颜色，用于重要级文字，内页标题信息
 */
+ (UIColor *)titleTextColor;

/**
 *  次要文本颜色
 */
+ (UIColor *)detailTextColor;

@end
