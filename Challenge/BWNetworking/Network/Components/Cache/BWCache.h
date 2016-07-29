//
//  BWCache.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWCache : NSObject

/**
 *  服务缓存单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  存储服务缓存
 *
 *  @param cachedData        缓存数据
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param requestParams     API 参数
 */
- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;

/**
 *  拉取服务缓存
 *
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param requestParams     API 参数
 *
 *  @return 缓存数据
 */
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams;

/**
 *  删除服务缓存
 *
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param requestParams     API 参数
 */
- (void)deleteCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                   methodName:(NSString *)methodName
                                requestParams:(NSDictionary *)requestParams;

/**
 *  清空服务缓存
 */
- (void)cleanCache;

@end
