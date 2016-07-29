//
//  NSDictionary+BWNetworkMethod.h
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BWNetworkMethod)

- (NSString *)BW_urlParamsStringSignature:(BOOL)isForSignature;

- (NSString *)BW_jsonString;

- (NSArray *)BW_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
