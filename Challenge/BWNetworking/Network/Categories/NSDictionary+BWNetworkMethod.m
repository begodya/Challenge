//
//  NSDictionary+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSDictionary+BWNetworkMethod.h"
#import "NSArray+BWNetworkMethod.h"

@implementation NSDictionary (BWNetworkMethod)

// 字符串前面没有问号，如果用于POST不用加问号，如果用于GET要加问号
- (NSString *)BW_urlParamsStringSignature:(BOOL)isForSignature {
    NSArray *sortedArray = [self BW_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray BW_paramsString];
}

// 字典转JSON
- (NSString *)BW_jsonString {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 转义参数
- (NSArray *)BW_transformedUrlParamsArraySignature:(BOOL)isForSignature {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = [self encodedString:obj];
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}


- (NSString*)encodedString:(NSString *)obj {
    NSString *charactersToEscape = @":/=,!$&'()*+;[]@#?^%\"`<>{}\\|~ ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodeURL = [obj stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodeURL;
}
@end
