//
//  BWTableViewCellImageView.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWTableViewCellImageView.h"

@implementation BWTableViewCellImageView

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

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initBaseData];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initBaseView];
}

- (void)initBaseData {
    if(!self.separateColor) {
        self.separateColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    }
}

- (void)initBaseView {
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)drawRect:(CGRect)rect {
    [self setClipsToBounds:NO];
    if(!self.separateColor) {
        self.separateColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat startX = 0+kShadowLeftBuffer;
    CGFloat startY = 0;
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    
    if (position_ == eGroupTableViewCellBackgroundPositionTop) {
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, startX, cornerRadius_+startY);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, startX, startY, startX+cornerRadius_, startY, cornerRadius_);
        }
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer-cornerRadius_, startY);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, rect.size.width-kShadowRightBuffer, startY, rect.size.width-kShadowRightBuffer, startY+cornerRadius_, cornerRadius_);
        }
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer, rect.size.height);
        CGContextAddLineToPoint(context, startX, rect.size.height);
        
        CGContextClosePath(context);
        CGContextFillPath(context);
        
        CGContextSetStrokeColorWithColor(context, self.separateColor.CGColor);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, rect.size.width, 0);
        CGContextStrokePath(context);
        
        if (self.isSelectedPage == NO) {
            CGContextSetStrokeColorWithColor(context, self.separateColor.CGColor);
            CGContextMoveToPoint(context, rect.size.width, rect.size.height);
            CGContextAddLineToPoint(context, rect.size.width-self.separatorLength, rect.size.height);
            CGContextStrokePath(context);
        }
        
    } else if (position_ == eGroupTableViewCellBackgroundPositionBottom) {
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer, startY);
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer, rect.size.height-cornerRadius_-kShadowBottomBuffer);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, rect.size.width-kShadowRightBuffer, rect.size.height-kShadowBottomBuffer, rect.size.width-kShadowRightBuffer-cornerRadius_, rect.size.height-kShadowBottomBuffer, cornerRadius_);
        }
        CGContextAddLineToPoint(context, startX+cornerRadius_, rect.size.height-kShadowBottomBuffer);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, startX, rect.size.height-kShadowBottomBuffer, startX, rect.size.height-kShadowBottomBuffer-cornerRadius_, cornerRadius_);
        }
        
        CGContextClosePath(context);
        CGContextFillPath(context);
        
        if (self.isSelectedPage == NO) {
            CGContextSetStrokeColorWithColor(context, self.separateColor.CGColor);
            CGContextMoveToPoint(context, 0, rect.size.height);
            CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
            CGContextStrokePath(context);
        }
        
    } else if (position_ == eGroupTableViewCellBackgroundPositionMiddle) {
        
        CGContextFillRect(context, CGRectMake(startX, 0, rect.size.width-kShadowLeftBuffer-kShadowRightBuffer, rect.size.height-kShadowTopBuffer));
        
        if (self.isSelectedPage == NO) {
            CGContextSetStrokeColorWithColor(context, self.separateColor.CGColor);
            CGContextMoveToPoint(context, rect.size.width-self.separatorLength, rect.size.height);
            CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
            CGContextStrokePath(context);
        }
        
    } else if (position_ == eGroupTableViewCellBackgroundPositionSingle) {
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, startX, cornerRadius_+startY);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, startX, startY, startX+cornerRadius_, startY, cornerRadius_);
        }
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer-cornerRadius_, startY);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, rect.size.width-kShadowRightBuffer, startY, rect.size.width-kShadowRightBuffer, startY+cornerRadius_, cornerRadius_);
        }
        CGContextAddLineToPoint(context, rect.size.width-kShadowRightBuffer, rect.size.height-cornerRadius_-kShadowBottomBuffer);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, rect.size.width-kShadowRightBuffer, rect.size.height-kShadowBottomBuffer, rect.size.width-kShadowRightBuffer-cornerRadius_, rect.size.height-kShadowBottomBuffer, cornerRadius_);
        }
        CGContextAddLineToPoint(context, startX+cornerRadius_, rect.size.height-kShadowBottomBuffer);
        if (cornerRadius_ > 0) {
            CGContextAddArcToPoint(context, startX, rect.size.height-kShadowBottomBuffer, startX, rect.size.height-kShadowBottomBuffer-cornerRadius_, cornerRadius_);
        }
        
        CGContextClosePath(context);
        CGContextFillPath(context);
        
        CGContextSetStrokeColorWithColor(context, self.separateColor.CGColor);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, rect.size.width, 0);
        CGContextStrokePath(context);
        
        if (self.isSelectedPage == NO) {
            CGContextMoveToPoint(context, 0, rect.size.height);
            CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
            CGContextStrokePath(context);
        }
    }
}

@end
