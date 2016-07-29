//
//  BWAppContext.m
//  Challenge
//
//  Created by 王貝 on 7/26/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWAppContext.h"
#import "AFNetworkReachabilityManager.h"

@implementation BWAppContext

#pragma mark - --------------------System--------------------
+ (instancetype)sharedInstance {
    static BWAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    
    return sharedInstance;
}

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - --------------------属性相关--------------------
- (BOOL)isReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

#pragma mark - --------------------接口API--------------------

#pragma mark ----------------------退出清空--------------------

@end
