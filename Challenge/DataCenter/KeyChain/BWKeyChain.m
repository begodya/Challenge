//
//  BWKeyChain.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWKeyChain.h"

@implementation BWKeyChain

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)keyInfo {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword, (__bridge_transfer id)kSecClass,
            keyInfo, (__bridge_transfer id)kSecAttrService,
            keyInfo, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock, (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)keyInfo data:(id)data {
    // Get search dictionary
    NSMutableDictionary *keyclainQuery = [self getKeyChainQuery:keyInfo];
    
    // Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keyclainQuery);
    
    // Add new item to search dictionary
    [keyclainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer  id)kSecValueData];
    
    // Add item to keyclain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keyclainQuery, NULL);
}

+ (id)load:(NSString *)keyInfo {
    id ret = nil;
    NSMutableDictionary *keyclainQuery = [self getKeyChainQuery:keyInfo];
    // configure the search setting
    [keyclainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keyclainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keyclainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", keyInfo, exception);
        }
        @finally {
        }
    }
    
    return ret;
}

+ (void)delete:(NSString *)keyInfo {
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:keyInfo];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

@end
