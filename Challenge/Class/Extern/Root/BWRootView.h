//
//  BWRootView.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWRootView : UIView

/**
 *  根据XIB获取视图对象
 *
 *  @param xibName    XIB名称
 *  @return 根据XIB获取视图的对象
 */
+ (UIView *)getViewFromXib:(NSString *)xibName;

/**
 *  根据XIB获取视图对象
 *
 *  @param xibName    XIB名称
 *  @param index      视图对象在XIB中的索引
 *  @return 根据XIB获取视图的对象
 */
+ (UIView *)getViewFromXib:(NSString *)xibName atIndex:(NSInteger)index;


/**
 *  window上全屏遮罩显示contentView
 *
 *  @param contentView 遮罩上要显示的视图
 */
- (void)showCoverViewWithContentView:(UIView *)contentView;

/**
 *  window上全屏遮罩显示contentView
 *
 *  @param contentView 遮罩上要显示的视图
 *  @param isHide 是否点击隐藏
 */
- (void)showCoverViewWithContentView:(UIView *)contentView
           isHideWhenTouchBackground:(BOOL)isHide;

/**
 *  隐藏window上全屏遮罩
 */
- (void)hideMaskView;

@end
