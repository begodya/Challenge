//
//  NSArray+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSArray+BWNetworkMethod.h"

@implementation NSArray (BWNetworkMethod)

// 字母排序后形成的参数字符串
- (NSString *)BW_paramsString {
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParam = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParam enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        } else {
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

// 数组转JSON
- (NSString *)BW_jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
