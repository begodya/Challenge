//
//  BWTableViewCellBackground.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWTableViewCellBackground.h"
#import "BWTableViewCellImageView.h"

@implementation BWTableViewCellBackground

@synthesize fillColor = fillColor_;
@synthesize strokeColor = strokeColor_;
@synthesize position = position_;
@synthesize cornerRadius = cornerRadius_;

#pragma mark - --------------------退出清空--------------------

#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseData];
        [self initBaseView];
    }
    return self;
}

#pragma mark 初始化数据
- (void)initBaseData {
    self.cornerRadius = 0.0;
    if(!self.separateColor) {
        self.separateColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    }
}

#pragma mark 初始化视图
- (void)initBaseView {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setClipsToBounds:NO];
}

- (void)startDraw {
    CGRect rect;
    if (position_ == eGroupTableViewCellBackgroundPositionTop) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position_ == eGroupTableViewCellBackgroundPositionBottom) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position_ == eGroupTableViewCellBackgroundPositionMiddle) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position_ == eGroupTableViewCellBackgroundPositionSingle) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else {
        rect = CGRectZero;
    }
    
    if (!imageView_) {
        imageView_ = [[BWTableViewCellImageView alloc] initWithFrame:rect];
    } else {
        [imageView_ setFrame:rect];
    }
    imageView_.isSelectedPage = self.isSelectedPage;
    imageView_.position = self.position;
    imageView_.cornerRadius = self.cornerRadius;
    imageView_.strokeColor = self.strokeColor;
    imageView_.fillColor = self.fillColor;
    imageView_.separatorLength = self.separatorLength;
    imageView_.separateColor = self.separateColor;
    
    if (imageView_.superview) {
        [imageView_ setNeedsDisplay];
    } else {
        [self addSubview:imageView_];
    }
}

- (void)redrawWithTemporaryPosition:(eGroupTableViewCellBackgroundPosition)position {
    CGRect rect;
    if (position == eGroupTableViewCellBackgroundPositionTop) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position == eGroupTableViewCellBackgroundPositionBottom) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position == eGroupTableViewCellBackgroundPositionMiddle) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else if (position == eGroupTableViewCellBackgroundPositionSingle) {
        rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else {
        rect = CGRectZero;
    }
    
    if (!tempImageView_) {
        tempImageView_ = [[BWTableViewCellImageView alloc] initWithFrame:rect];
    } else {
        [tempImageView_ setFrame:rect];
    }
    tempImageView_.isSelectedPage = YES;
    tempImageView_.position = position;
    tempImageView_.cornerRadius = self.cornerRadius;
    tempImageView_.strokeColor = self.strokeColor;
    tempImageView_.fillColor = self.fillColor;
    tempImageView_.separatorLength = self.separatorLength;
    tempImageView_.separateColor = self.separateColor;
    
    if (tempImageView_.superview) {
        [tempImageView_ setNeedsDisplay];
    } else {
        [self addSubview:tempImageView_];
    }
    [imageView_ setHidden:YES];
}

- (void)restoreOriginPosition {
    [imageView_ setHidden:NO];
    [tempImageView_ removeFromSuperview];
}

@end
