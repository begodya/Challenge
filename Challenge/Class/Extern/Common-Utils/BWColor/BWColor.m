//
//  BWColor.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWColor.h"

#define BWCOLORALPHA(name, hexValue, alphaValue) \
+ (UIColor *)name {\
    return [self colorFromHex:hexValue alpha:alphaValue];\
}

#define BWCOLOR(name, hex) BWCOLORALPHA(name, hex, 1.0)

#define BWCOLORALIAS(alias, paletteName)\
+ (UIColor *)alias {\
    return [self paletteName];\
}

@implementation BWColor

BWCOLOR(defaultBackgroundColor, @"f5f5f5");
BWCOLOR(navigationBarBackgroundColor, @"ffffff");
BWCOLOR(navigationBarTitleColor, @"000000");
BWCOLOR(titleTextColor, @"000000");
BWCOLOR(detailTextColor, @"646464");

#pragma mark - Private

+ (UIColor *)colorFromHex:(NSString *)hexValue alpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexValue];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0
                            blue:((float)(rgbValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
