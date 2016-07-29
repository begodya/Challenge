//
//  BWTableViewCellImageView.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWTableViewCellBackground.h"

#define kShadowLeftBuffer 0
#define kShadowRightBuffer 0
#define kShadowTopBuffer 0
#define kShadowBottomBuffer 0

@interface BWTableViewCellImageView : UIView {
    eGroupTableViewCellBackgroundPosition position_;
    CGFloat cornerRadius_;
    UIColor *fillColor_;
    UIColor *strokeColor_;
}

/** 是否是选中背景 */
@property (nonatomic, assign) BOOL isSelectedPage;
/** 填充色 */
@property (nonatomic, strong) UIColor *fillColor;
/** 边线色 */
@property (nonatomic, strong) UIColor *strokeColor;
/** 边角半径 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** cell位置类型 */
@property (nonatomic, assign) eGroupTableViewCellBackgroundPosition position;
/** 分割线长度(右对齐) */
@property (nonatomic) CGFloat separatorLength;
/** 分割线颜色 */
@property (nonatomic, strong) UIColor *separateColor;

/**
 初始化数据
 */
- (void)initBaseData;

/**
 初始化视图
 */
- (void)initBaseView;


@end
