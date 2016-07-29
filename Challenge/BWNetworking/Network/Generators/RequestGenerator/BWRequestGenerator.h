//
//  BWRequestGenerator.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWRequestGenerator : NSObject

/**
 *  服务请求生成器单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  服务请求生成
 *
 *  @param serviceIdentifier 服务标识
 *  @param requestParams     API 参数
 *  @param methodName        API 名称
 *
 *  @return 服务请求对象
 */
- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

/**
 *  服务请求生成
 *
 *  @param serviceIdentifier 服务标识
 *  @param requestParams     API 参数
 *  @param methodName        API 名称
 *
 *  @return 服务请求对象
 */
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName;

/**
 *  服务请求生成
 *
 *  @param serviceIdentifier 服务标识
 *  @param requestParams     API 参数
 *  @param methodName        API 名称
 *
 *  @return 服务请求对象
 */
- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

/**
 *  服务请求生成
 *
 *  @param serviceIdentifier 服务标识
 *  @param requestParams     API 参数
 *  @param methodName        API 名称
 *
 *  @return 服务请求对象
 */
- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName;

@end
