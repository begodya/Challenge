//
//  BWNavigationController.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define SYSTEM_GESTURE  // 系统右滑返回手势
#define CUSTOM_GESTURE  // 自定义右滑返回手势

@interface BWNavigationController : UINavigationController

// Enable the drag to back interaction, Default is YES.
@property (nonatomic, assign) BOOL canDragBack;

/**
 * present ViewController（外部无需设置rootview，内部转换）
 *
 * @param viewControllerToPresent
 * @param animated animated flag
 */
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag;

@end
