//
//  BWH5ViewController.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWRootViewController.h"

@interface BWH5ViewController : BWRootViewController

- (id)initWithURL:(NSURL *)url;

@end



#pragma mark -- 进入H5页面入口
@interface BWH5ViewController(URL)

/*
 进入页面以Push方式
 
 @param url             进入页面的URL地址
 @param viewController  进入的VC
 */
+ (BWH5ViewController *)loadURL:(NSURL *)url fromViewController:(UIViewController *)viewController;

/*
 进入页面以Push方式
 
 @param url             进入页面的URL地址
 @param title           页面标题
 @param viewController  进入的VC
 */
+ (BWH5ViewController *)loadURL:(NSURL *)url title:(NSString *)title fromViewController:(UIViewController *)viewController;

/*
 进入页面以Present方式
 
 @param url             进入页面的URL地址
 @param title           页面标题
 @param viewController  进入的VC
 */
+ (BWH5ViewController *)presentURL:(NSURL *)url title:(NSString *)title fromViewController:(UIViewController *)viewController;

@end




#pragma mark -- 内部页面调用，外部请勿使用
@interface BWH5ViewController(Private)

/*
 进入页面以Push方式
 
 @param url             进入页面的URL地址
 @param title           页面标题
 @param isShow          是否显示工具栏
 @param cls             进入子类的类名
 @param viewController  进入的VC
 */
+ (BWH5ViewController *)loadURL:(NSURL *)url
                          title:(NSString *)title
                  isShowToolBar:(BOOL)isShow
                       subClass:(Class)cls
             fromViewController:(UIViewController *)viewController;

/*
 进入页面以Present方式
 
 @param url             进入页面的URL地址
 @param title           页面标题
 @param isShow          是否显示工具栏
 @param cls             进入子类的类名
 @param viewController  进入的VC
 */
+ (BWH5ViewController *)presentURL:(NSURL *)url
                             title:(NSString *)title
                     isShowToolBar:(BOOL)isShow
                          subClass:(Class)cls
                fromViewController:(UIViewController *)viewController;
@end
