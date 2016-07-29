//
//  NSObject+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSObject+BWNetworkMethod.h"

@implementation NSObject (BWNetworkMethod)

- (id)BW_defaultValue:(id)defaultData {
    if (![defaultData isKindOfClass:[self class]]) {
        return defaultData;
    }
    if ([self BW_isEmptyObject]) {
        return defaultData;
    }
    
    return self;
}

- (BOOL)BW_isEmptyObject {
    if ([self isEqual:[NSNull class]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
