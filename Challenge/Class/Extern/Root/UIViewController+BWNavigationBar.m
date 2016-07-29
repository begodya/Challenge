//
//  UIViewController+BWNavigationBar.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "UIViewController+BWNavigationBar.h"
#import "BWNavigationBar.h"
#import "BWColor.h"

@implementation UIViewController (BWNavigationBar)

#pragma mark - --------------------接口API--------------------

- (void)setCustomTitle:(NSString *)title {
    if (title.length == 0) {
        return;
    }
    NSDictionary *attribute = @{NSFontAttributeName:kNavigationBarTitleFont};
    CGFloat width = [title sizeWithAttributes:attribute].width;
    width = (width > kNavigationBarTitleViewMaxWidth) ? kNavigationBarTitleViewMaxWidth : width;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kNavigationBarTitleViewMaxHeight)];
    [titleLabel setFont:kNavigationBarTitleFont];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[BWColor navigationBarTitleColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = titleLabel;
}

- (void)setCustomTitle:(NSString *)title withSubTitle:(NSString *)subTitle {
    if (title.length == 0) {
        return;
    }
    NSDictionary *attribute = @{NSFontAttributeName:kNavigationBarTitleFont};
    CGFloat width = [title sizeWithAttributes:attribute].width;
    width = (width > kNavigationBarTitleViewMaxWidth) ? kNavigationBarTitleViewMaxWidth : width;
    
    CGFloat subWidth = [subTitle sizeWithAttributes:attribute].width;
    if (width < subWidth) {
        width = subWidth;
    }
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, kNavigationBarTitleViewMaxHeight)];
    [titleView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kNavigationBarTitleViewMaxHeight/2)];
    [titleLabel setFont:kNavigationBarTitleFont];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[BWColor navigationBarTitleColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kNavigationBarTitleViewMaxHeight/2, width, kNavigationBarTitleViewMaxHeight/2)];
    [subTitleLabel setFont:[BWFont customFontWithSize:15.f]];
    [subTitleLabel setText:subTitle];
    [subTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [subTitleLabel setTextColor:[BWColor detailTextColor]];
    [subTitleLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:subTitleLabel];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = titleView;
}

- (void)setCustomTitle:(NSString *)title withColor:(UIColor *)color {
    if (title.length == 0) {
        return;
    }
    NSDictionary *attribute = @{NSFontAttributeName:kNavigationBarTitleFont};
    CGFloat width = [title sizeWithAttributes:attribute].width;
    width = (width > kNavigationBarTitleViewMaxWidth) ? kNavigationBarTitleViewMaxWidth : width;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, kNavigationBarTitleViewMaxHeight)];
    [titleLabel setFont:kNavigationBarTitleFont];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = titleLabel;
}

- (void)setCustomTitleView:(UIView *)titleView {
    self.navigationItem.titleView = nil;
    self.navigationItem.titleView = titleView;
}

- (void)setBackBarButtonItem:(UIBarButtonItem *)item {
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setBackBarButtonWithTarget:(id)target action:(SEL)selector {
    // 第一种方法：
    CGFloat barItemMargin = 22.f;
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image = [UIImage imageNamed:@"btn_back_arrow.png"];
    UIImage* pressedImage = [UIImage imageNamed:@"btn_back_arrow_focus.png"];
    [customButton setImage:image forState:UIControlStateNormal];
    [customButton setImage:pressedImage forState:UIControlStateHighlighted];
    
    [customButton setFrame:CGRectMake(0, 0, 22+barItemMargin, 44)];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self setBackBarButtonItem:[BWNavigationBar createBarButtonItemWithCustomView:customButton]];
    
    // 第二种方法：
//    [self setBackBarButtonItem:[SZNavigationBar createBarButtonItemWithImage:[UIImage imageNamed:@"btn_back_arrow"] style:UIBarButtonItemStylePlain target:target action:selector]];
}

- (void)setCloseBarButtonItem:(UIBarButtonItem *)item {
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setCloseBarButtonWithTarget:(id)target action:(SEL)selector {
    CGFloat barItemMargin = 22.f;
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* image = [UIImage imageNamed:@"btn_close_cross.png"];
    UIImage* pressedImage = [UIImage imageNamed:@"btn_close_cross_focus.png"];
    [customButton setImage:image forState:UIControlStateNormal];
    [customButton setImage:pressedImage forState:UIControlStateHighlighted];
    
    [customButton setFrame:CGRectMake(0, 0, 22+barItemMargin, 44)];
    [customButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self setBackBarButtonItem:[BWNavigationBar createBarButtonItemWithCustomView:customButton]];
    
//    [self setBackBarButtonItem:[SZNavigationBar createBarButtonItemWithImage:[UIImage imageNamed:@"btn_close_cross"] style:UIBarButtonItemStylePlain target:target action:selector]];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)item {
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setLeftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    [self setLeftBarButtonItem:[BWNavigationBar createBarButtonItemWithTitle:title target:target action:selector]];
}


- (void)setRightBarButtonItem:(UIBarButtonItem *)item {
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    [self setRightBarButtonItem:[BWNavigationBar createBarButtonItemWithTitle:title target:target action:selector]];
}

- (void)setRightBarButtonWithTitle:(NSString *)title textColor:(UIColor *)color target:(id)target action:(SEL)selector {
    [self setRightBarButtonItem:[BWNavigationBar createBarButtonItemWithTitle:title textColor:color target:target action:selector]];
}

- (void)serRightBarButtonWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    [self setRightBarButtonItem:[BWNavigationBar createBarButtonItemWithTitle:title style:style target:self action:action]];
}

- (void)setBackBarButtonItemHidden:(BOOL)hidden {
    self.navigationItem.backBarButtonItem.customView.hidden = hidden;
}

- (void)setLeftBarButtonItemHidden:(BOOL)hidden {
    self.navigationItem.leftBarButtonItem.customView.hidden = hidden;
    
}

- (void)setRightBarButtonItemHidden:(BOOL)hidden {
    self.navigationItem.rightBarButtonItem.customView.hidden = hidden;
}

- (void)setLeftBarButtonItemEnbled:(BOOL)enbled {
    self.navigationItem.leftBarButtonItem.enabled = enbled;
}

- (void)setRightBarButtonItemEnbled:(BOOL)enbled {
    self.navigationItem.rightBarButtonItem.enabled = enbled;
}

@end
