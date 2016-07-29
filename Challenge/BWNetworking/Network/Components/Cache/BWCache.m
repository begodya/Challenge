//
//  BWCache.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWCache.h"
#import "NSDictionary+BWNetworkMethod.h"
#import "BWNetworkConfig.h"
#import "BWCachedObject.h"

@interface BWCache()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation BWCache

#pragma mark - --------------------System--------------------
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static BWCache *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWCache alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - --------------------功能函数--------------------

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary *)requestParams {
    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams BW_urlParamsStringSignature:NO]];
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key {
    BWCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject == nil) {
        cachedObject = [[BWCachedObject alloc] init];
    }
    [cachedObject updateContentData:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key {
    BWCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isEmpty || cachedObject.isOutdated) {
        return nil;
    } else {
        return cachedObject.contentData;
    }
}

- (void)deleteCachedDataWithKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
}

#pragma mark - --------------------属性相关--------------------

- (NSCache *)cache {
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kBWCacheCountLimit;
    }
    
    return _cache;
}

#pragma mark - --------------------接口API--------------------

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams {
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier
                                                               methodName:methodName
                                                            requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams {
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                            methodName:methodName
                                                         requestParams:requestParams]];
}

- (void)deleteCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                   methodName:(NSString *)methodName
                                requestParams:(NSDictionary *)requestParams {
    [self deleteCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier
                                                      methodName:methodName
                                                   requestParams:requestParams]];
}

- (void)cleanCache {
    [self.cache removeAllObjects];
}
#pragma mark ----------------------退出清空--------------------

@end
