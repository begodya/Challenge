//
//  NSURLRequest+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSURLRequest+BWNetworkMethod.h"
#import <objc/runtime.h>

static void *BWNetworkRequestParams;

@implementation NSURLRequest (BWNetworkMethod)

- (void)setRequestParams:(NSDictionary *)requestParams {
    objc_setAssociatedObject(self, &BWNetworkRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    return objc_getAssociatedObject(self, &BWNetworkRequestParams);
}

@end
