//
//  BWKeyChain.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWKeyChain : NSObject

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)keyInfo;

+ (void)save:(NSString *)keyInfo data:(id)data;

+ (id)load:(NSString *)keyInfo;

+ (void)delete:(NSString *)keyInfo;

@end
