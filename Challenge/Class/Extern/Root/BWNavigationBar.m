//
//  BWNavigationBar.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWNavigationBar.h"
#import "BWColor.h"

@implementation BWNavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBaseView];
    }
    return self;
}

- (void)initBaseView {
    [self setBarTintColor:BWColorRGB(37, 156, 208)];
}

#pragma mark - --------------------system---------------------------

- (void)setBarTintColor:(UIColor *)barTintColor {
    [super setBarTintColor:barTintColor];
}

#pragma mark - --------------------public method--------------------

+ (UIBarButtonItem *)createBarButtonItemWithCustomView:(UIView *)view {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    if (!title) {
        return nil;
    }
    
    CGFloat barItemMargin = 11.f;
//    if (IOS_7_OR_LATER()) {
//        barItemMargin = 0.f;
//    }else{
//        barItemMargin = 11.f;
//    }
    NSDictionary *attribute = @{NSFontAttributeName:kNavigationBarButtonFont};
    CGFloat width = [title sizeWithAttributes:attribute].width + barItemMargin;
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton.titleLabel setFont:kNavigationBarButtonFont];
    
    [customButton setTitleColor:kNavigationBarButtonNormalColor forState:UIControlStateNormal];
    [customButton setTitleColor:kNavigationBarButtonHighlightColor forState:UIControlStateHighlighted];
    [customButton setTitleColor:kNavigationBarButtonDisableColor forState:UIControlStateDisabled];
    
    [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    [customButton setFrame:CGRectMake(0, 0, width+5, 44)];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [BWNavigationBar createBarButtonItemWithCustomView:customButton];
}

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title textColor:(UIColor *)color target:(id)target action:(SEL)action {
    if (!title) {
        return nil;
    }
    
    CGFloat barItemMargin = 11.f;
//    if (IOS_7_OR_LATER()) {
//        barItemMargin = 0.f;
//    }else{
//        barItemMargin = 11.f;
//    }
    NSDictionary *attribute = @{NSFontAttributeName:kNavigationBarButtonFont};
    CGFloat width = [title sizeWithAttributes:attribute].width + barItemMargin;
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton.titleLabel setFont:kNavigationBarButtonFont];
    
    [customButton setTitleColor:color forState:UIControlStateNormal];
    //    [customButton setTitleColor:kNavigationBarButtonHighlightColor forState:UIControlStateHighlighted];
    [customButton setTitleColor:kNavigationBarButtonDisableColor forState:UIControlStateDisabled];
    
    [customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    [customButton setFrame:CGRectMake(0, 0, width+5, 44)];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [BWNavigationBar createBarButtonItemWithCustomView:customButton];
}

+ (UIBarButtonItem *)createBarButtonItemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:style target:target action:action];
    return item;
}

+ (UIBarButtonItem *)createBarButtonItemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
    return item;
}

@end
