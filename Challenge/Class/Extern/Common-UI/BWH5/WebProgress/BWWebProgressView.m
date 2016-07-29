//
//  BWWebProgressView.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWWebProgressView.h"

#define PROGRESS_BAR_HEIGHT 2.f

@implementation BWWebProgressView

#pragma mark - --------------------System--------------------

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureViews];
}

#pragma mark - --------------------功能函数--------------------

-(void)configureViews {
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.frame = CGRectMake(0, 44.f-PROGRESS_BAR_HEIGHT, self.bounds.size.width, PROGRESS_BAR_HEIGHT);
    
    
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    CGRect frame = _progressBarView.frame;
    frame.size.width = 0.f;
    _progressBarView.frame = frame;

    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color
    if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)] && UIApplication.sharedApplication.delegate.window.tintColor) {
        tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    }
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    
    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration = 0.27f;
    _fadeOutDelay = 0.1f;
}

-(void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}
#pragma mark - --------------------手势事件--------------------
#pragma mark 各种手势处理函数注释

#pragma mark - --------------------按钮事件--------------------
#pragma mark 按钮点击函数注释

#pragma mark - --------------------代理方法--------------------
#pragma mark - 代理种类注释
#pragma mark 代理函数注释

#pragma mark - --------------------属性相关--------------------
#pragma mark 属性操作函数注释

#pragma mark - --------------------接口API--------------------

- (void)setProgress:(float)progress animated:(BOOL)animated {
    BOOL isGrowing = progress > 0.0;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = _progressBarView.frame;
        frame.size.width = progress * self.bounds.size.width;
        _progressBarView.frame = frame;
    } completion:nil];
    
    if (progress >= 1.0) {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 1.0;
        } completion:nil];
    }
}

@end
