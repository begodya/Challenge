//
//  BWAPIProxy.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWURLResponse.h"

typedef void(^BWCallback)(BWURLResponse *response);

@interface BWAPIProxy : NSObject

/**
 *  服务代理器单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  GET服务代理
 *
 *  @param apiParams         API 参数
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param success           成功回调
 *  @param fail              失败回调
 *
 *  @return 服务ID
 */
- (NSInteger)callGETWithParams:(NSDictionary *)apiParams
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                       success:(BWCallback)success
                          fail:(BWCallback)fail;

/**
 *  POST服务代理
 *
 *  @param apiParams         API 参数
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param success           成功回调
 *  @param fail              失败回调
 *
 *  @return 服务ID
 */
- (NSInteger)callPOSTWithParams:(NSDictionary *)apiParams
              serviceIdentifier:(NSString *)serviceIdentifier
                     methodName:(NSString *)methodName
                        success:(BWCallback)success
                           fail:(BWCallback)fail;

/**
 *  PUT服务代理
 *
 *  @param apiParams         API 参数
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param success           成功回调
 *  @param fail              失败回调
 *
 *  @return 服务ID
 */
- (NSInteger)callPUTWithParams:(NSDictionary *)apiParams
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                       success:(BWCallback)success
                          fail:(BWCallback)fail;

/**
 *  DELETE服务代理
 *
 *  @param apiParams         API 参数
 *  @param serviceIdentifier 服务标识
 *  @param methodName        API 名称
 *  @param success           成功回调
 *  @param fail              失败回调
 *
 *  @return 服务ID
 */
- (NSInteger)callDELETEWithParams:(NSDictionary *)apiParams
                serviceIdentifier:(NSString *)serviceIdentifier
                       methodName:(NSString *)methodName
                          success:(BWCallback)success
                             fail:(BWCallback)fail;

/**
 *  根据服务ID取消服务
 *
 *  @param requestID 服务ID
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

/**
 *  批量取消服务操作
 *
 *  @param requestIDList 服务队列
 */
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
