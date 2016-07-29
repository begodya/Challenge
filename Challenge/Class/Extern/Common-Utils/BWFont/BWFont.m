//
//  BWFont.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWFont.h"

/** 系统字体*/
#define CUSTOM_FONTNAME         @"Helvetica"
#define CUSTOM_FONTNAME_BOLD    @"Helvetica-Bold"

@implementation BWFont

#pragma mark - Shared

+ (UIFont *)navigationBarTitleFont {
    static UIFont *sNavigationBarTitleFont;
    return [self fontWithCache:sNavigationBarTitleFont
                          name:CUSTOM_FONTNAME
                          size:18.f];
}

+ (UIFont *)customFontWithSize:(CGFloat)size {
    static UIFont *sCustomFont;
    return [self fontWithCache:sCustomFont
                          name:CUSTOM_FONTNAME
                          size:size];
}

+ (UIFont *)customBoldFontWithSize:(CGFloat)size {
    static UIFont *sCustomFont;
    return [self fontWithCache:sCustomFont
                          name:CUSTOM_FONTNAME_BOLD
                          size:size];
}

#pragma mark - Private
/*!
 *  Create or reuse a font
 *
 *  @param cachedFont Static variable for caching.
 *  @param name Name of the font.
 *  @param size Size of the font.
 *
 *  @return The font.
 */
+ (UIFont *)fontWithCache:(UIFont *)cachedFont
                     name:(NSString *)name
                     size:(CGFloat)size {
    if (!cachedFont) {
        cachedFont = [UIFont fontWithName:name size:size];
    }
    
    // Font family
//    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    NSLog(@"[familyNames count]===%d",[familyNames count]);
//    for(indFamily=0;indFamily<[familyNames count];++indFamily) {
//        DLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
//
//        for(indFont=0; indFont<[fontNames count]; ++indFont) {
//            DLog(@"Font name: %@",[fontNames objectAtIndex:indFont]);
//        }
//    }
    return cachedFont;
}

@end
