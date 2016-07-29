//
//  BWFullMaskView.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWFullMaskView.h"

@implementation BWFullMaskView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];
    }
    return self;
}

- (void)initData {
    self.isHideWhenTouchBackground = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.isHideWhenTouchBackground) {
        [self hideMaskView];
    }
}

- (void)hideMaskView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(maskView:willRemoveFromSuperView:)]) {
        [self.delegate maskView:self willRemoveFromSuperView:self.superview];
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        [self setAlpha:0.f];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
