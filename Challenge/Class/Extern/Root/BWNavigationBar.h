//
//  BWNavigationBar.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWFont.h"

#define kNavigationBarButtonFont            [BWFont customFontWithSize:17.f]
#define kNavigationBarTitleFont             [BWFont navigationBarTitleFont]

#define kNavigationBarButtonNormalColor     [UIColor redColor]
#define kNavigationBarButtonHighlightColor  [[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0] colorWithAlphaComponent:0.4]
#define kNavigationBarButtonDisableColor    [[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0] colorWithAlphaComponent:0.4]

#define kNavigationBarTitleViewMaxWidth 190
#define kNavigationBarTitleViewMaxHeight 44

@interface BWNavigationBar : UINavigationBar

/**
 *  通过标题生成UIBarButtonItem
 *
 *  @param title 标题
 *  @param target 事件响应对象
 *  @param action 事件响应方法
 */
+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  通过标题和颜色生成UIBarButtonItem
 *
 *  @param title  标题
 *  @param color  文本颜色
 *  @param target 事件响应对象
 *  @param action 事件响应方法
 */
+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title textColor:(UIColor *)color target:(id)target action:(SEL)action;

/**
 *  通过自定义视图生成UIBarButtonItem
 *
 *  @param view 自定义视图
 */
+ (UIBarButtonItem *)createBarButtonItemWithCustomView:(UIView *)view;

/**
 *  通过图片生成UIBarButtonItem
 *
 *  @param image  图片
 *  @param style  类型
 *  @param target 事件响应对象
 *  @param action 事件响应方法
 */
+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;

/**
 *  通过标题生成UIBarButtonItem
 *
 *  @param title  标题
 *  @param style  类型
 *  @param target 事件响应对象
 *  @param action 事件响应方法
 */
+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action;

@end
