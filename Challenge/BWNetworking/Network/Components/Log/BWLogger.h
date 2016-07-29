//
//  BWLogger.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWService.h"
#import "BWURLResponse.h"

@interface BWLogger : NSObject

/**
 *  服务日志单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  服务请求日志输出
 *
 *  @param request       请求对象
 *  @param apiName       API 名称
 *  @param service       服务对象
 *  @param requestParams API 参数
 *  @param httpMethod    HTTP 方法
 */
+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                        apiName:(NSString *)apiName
                        service:(BWService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;

/**
 *  服务返回日志输出
 *
 *  @param response       返回对象
 *  @param responseString 返回数据
 *  @param request        请求对象
 *  @param error          错误对象
 */
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

/**
 *  服务缓存日志输出
 *
 *  @param response   返回对象
 *  @param service    服务对象
 *  @param methodName API 名称
 */
+ (void)logDebugInfoWithCachedResponse:(BWURLResponse *)response
                               service:(BWService *)service
                               apiName:(NSString *)apiName;
@end
