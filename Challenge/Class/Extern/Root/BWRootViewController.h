//
//  BWRootViewController.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWNavigationController.h"

typedef enum {
    eCoverViewPositionTypeCenter,
    eCoverViewPositionTypeTop,
    eCoverViewPositionTypeBottom,
    eCoverViewPositionTypeCustome,
} eCoverViewPositionType;

@interface BWRootViewController : UIViewController

/** 导航控制器 */
@property (nonatomic, weak) BWNavigationController *bwNavigationController;
/**	上一级页面VC */
@property (nonatomic, weak) BWRootViewController *bwParentViewController;

/**
 * 返回按钮点击，特殊情况可以重载此方法
 *
 * @param sender  返回按钮对象
 */
- (void)backBarButtonClicked:(id)sender;

/**
 * 返回按钮点击，特殊情况可以重载此方法
 *
 * @param sender  返回按钮对象
 */
- (void)closeBarButtonClicked:(id)sender;

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
 *  window上全屏遮罩显示contentView
 *
 *  @param contentView 遮罩上要显示的视图
 *  @param alpha alpha值
 */
- (void)showCoverViewWithContentView:(UIView *)contentView
                     backgroundAlpha:(CGFloat)alpha;

/**
 *  window上全屏遮罩显示contentView
 *
 *  @param contentView 遮罩上要显示的视图
 *  @param isHide 是否点击隐藏
 *  @param alpha alpha值
 *  @param positionType 位置类型
 */
- (void)showCoverViewWithContentView:(UIView *)contentView
           isHideWhenTouchBackground:(BOOL)isHide
                     backgroundAlpha:(CGFloat)alpha
                            position:(eCoverViewPositionType)positionType;

@end
