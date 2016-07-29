//
//  BWFont.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@interface BWFont : NSObject

/**
 *  导航栏字体
 */
+ (UIFont *)navigationBarTitleFont;

/**
 *  自定义字体
 */
+ (UIFont *)customFontWithSize:(CGFloat)size;

+ (UIFont *)customBoldFontWithSize:(CGFloat)size;

@end
