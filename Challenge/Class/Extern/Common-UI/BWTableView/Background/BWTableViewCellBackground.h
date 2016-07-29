//
//  BWTableViewCellBackground.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eGroupTableViewCellBackgroundPositionNone = 0,
    eGroupTableViewCellBackgroundPositionTop = 1,   //section中居于顶部
    eGroupTableViewCellBackgroundPositionMiddle,    //section中居于中间
    eGroupTableViewCellBackgroundPositionBottom,    //section中居于底部
    eGroupTableViewCellBackgroundPositionSingle,    //单个cell的section
} eGroupTableViewCellBackgroundPosition;


@class BWTableViewCellImageView;


@interface BWTableViewCellBackground : UIView {
    eGroupTableViewCellBackgroundPosition position_;
    CGFloat cornerRadius_;
    UIColor *fillColor_;
    UIColor *strokeColor_;
    BWTableViewCellImageView *imageView_;
    BWTableViewCellImageView *tempImageView_;
}

/** 是否是选中背景 */
@property (nonatomic, assign) BOOL isSelectedPage;
/** 填充颜色*/
@property (nonatomic, strong) UIColor *fillColor;
/** 边线颜色*/
@property (nonatomic, strong) UIColor *strokeColor;
/** cell位置类型*/
@property (nonatomic, assign) eGroupTableViewCellBackgroundPosition position;
/** 边角半径*/
@property (nonatomic, assign) CGFloat cornerRadius;
/** 分割线长度(右对齐) */
@property (nonatomic, assign) CGFloat separatorLength;
/** 分割线颜色 */
@property (nonatomic, strong) UIColor *separateColor;

/** 开始绘制*/
- (void)startDraw;
/** 重新绘制*/
- (void)redrawWithTemporaryPosition:(eGroupTableViewCellBackgroundPosition)position;
- (void)restoreOriginPosition;


@end
