//
//  NSString+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSString+BWNetworkMethod.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (BWNetworkMethod)

- (NSString *)AX_md5 {
    NSData *inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString *hashString = [[NSMutableString alloc] init];
    int i = 0;
    for (i = 0; i<CC_MD5_DIGEST_LENGTH; ++i) {
        [hashString appendFormat:@"%02X", outputData[i]];
    }
    return hashString;
}

@end
