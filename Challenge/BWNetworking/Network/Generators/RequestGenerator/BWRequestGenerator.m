//
//  BWRequestGenerator.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "BWNetwork.h"
#import "NSURLRequest+BWNetworkMethod.h"
#import "BWService.h"
#import "BWServiceFactory.h"
#import "BWLogger.h"

@interface BWRequestGenerator()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation BWRequestGenerator

#pragma mark - --------------------System--------------------
+ (instancetype)sharedInstance {
    static BWRequestGenerator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWRequestGenerator alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - --------------------属性相关--------------------
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [[AFHTTPRequestSerializer alloc] init];
        _httpRequestSerializer.timeoutInterval = kBWNetworkTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _httpRequestSerializer;
}

#pragma mark - --------------------接口API--------------------

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName {
    BWService *service = [[BWServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.host, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET"
                                                                URLString:urlString
                                                               parameters:requestParams
                                                                    error:NULL];
    request.requestParams = requestParams;
    
    // 服务Request日志
    [BWLogger logDebugInfoWithRequest:request
                              apiName:methodName
                              service:service
                        requestParams:requestParams
                           httpMethod:@"GET"];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName {
    BWService *service = [[BWServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.host, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST"
                                                                       URLString:urlString
                                                                      parameters:requestParams
                                                                           error:NULL];
    request.requestParams = requestParams;
    
    // 服务Request日志
    [BWLogger logDebugInfoWithRequest:request
                              apiName:methodName
                              service:service
                        requestParams:requestParams
                           httpMethod:@"POST"];
    return request;
}

- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName {
    BWService *service = [[BWServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.host, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT"
                                                                       URLString:urlString
                                                                      parameters:requestParams
                                                                           error:NULL];
    request.requestParams = requestParams;
    
    // 服务Request日志
    [BWLogger logDebugInfoWithRequest:request
                              apiName:methodName
                              service:service
                        requestParams:requestParams
                           httpMethod:@"PUT"];
    return request;
}

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName {
    BWService *service = [[BWServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", service.host, methodName];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE"
                                                                       URLString:urlString
                                                                      parameters:requestParams
                                                                           error:NULL];
    request.requestParams = requestParams;
    
    // 服务Request日志
    [BWLogger logDebugInfoWithRequest:request
                              apiName:methodName
                              service:service
                        requestParams:requestParams
                           httpMethod:@"DELETE"];
    return request;
}


#pragma mark ----------------------退出清空--------------------

@end
