//
//  BWFullMaskView.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWFullMaskView;

@protocol BWFullMaskViewDelegate <NSObject>

- (void)maskView:(BWFullMaskView *)view willRemoveFromSuperView:(UIView *)superView;

@end


@interface BWFullMaskView : UIView

@property (nonatomic, weak) id<BWFullMaskViewDelegate> delegate;
@property (nonatomic, assign) BOOL isHideWhenTouchBackground;

- (void)hideMaskView;

@end
