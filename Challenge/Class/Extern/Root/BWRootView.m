//
//  BWRootView.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWRootView.h"
#import "BWFullMaskView.h"

@interface BWRootView() <BWFullMaskViewDelegate> {
    BWFullMaskView *maskView_;
    UIWindow *applicationWindow_;
}
@end

@implementation BWRootView

#pragma mark - --------------------初始化--------------------

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseData];
    }
    return self;
}

- (void)initBaseData {
    applicationWindow_ = [[[UIApplication sharedApplication] delegate] window];
}

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - SZFullMaskViewDelegate
- (void)maskView:(BWFullMaskView *)view willRemoveFromSuperView:(UIView *)superView {
    maskView_ = nil;
}

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API--------------------

#pragma mark - 通过XIB获取视图对象
+ (UIView *)getViewFromXib:(NSString *)xibName {
    return [self getViewFromXib:xibName atIndex:0];
}

#pragma mark 通过XIB和index获取视图对象
+ (UIView *)getViewFromXib:(NSString *)xibName atIndex:(NSInteger)index {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil];
    UIView  *view = nil;
    if (array && array.count > index) {
        view  = [array objectAtIndex:index];
    }
    
    return view;
}

#pragma mark window上全屏遮罩显示contentView
- (void)showCoverViewWithContentView:(UIView *)contentView {
    [self showCoverViewWithContentView:contentView isHideWhenTouchBackground:YES];
}

#pragma mark window上全屏遮罩显示contentView
- (void)showCoverViewWithContentView:(UIView *)contentView isHideWhenTouchBackground:(BOOL)isHide {
    if (!maskView_) {
        maskView_ = [[BWFullMaskView alloc] initWithFrame:applicationWindow_.bounds];
        [maskView_ setDelegate:self];
        [maskView_ setAlpha:0.0f];
        [maskView_ setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    } else {
        [[maskView_ subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [maskView_ setIsHideWhenTouchBackground:isHide];
    [contentView setCenter:CGPointMake(maskView_.bounds.size.width/2.0, maskView_.bounds.size.height/2.0)];
    [maskView_ addSubview:contentView];
    
    [applicationWindow_ addSubview:maskView_];
    
    [UIView animateWithDuration:.5f animations:^{
        [maskView_ setAlpha:1.0f];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 隐藏全屏遮盖显示contentView
- (void)hideMaskView {
    [maskView_ hideMaskView];
}

#pragma mark - --------------------退出清空--------------------
-(void)dealloc{
    
}

@end
