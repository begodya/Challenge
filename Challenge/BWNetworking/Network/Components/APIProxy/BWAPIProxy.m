//
//  BWAPIProxy.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWAPIProxy.h"
#import "BWRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "BWLogger.h"

@interface BWAPIProxy()

@property (nonatomic, strong) NSMutableDictionary *dispatchMap;
@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

@end

@implementation BWAPIProxy

#pragma mark - --------------------System--------------------

+ (instancetype)sharedInstance {
    static BWAPIProxy *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWAPIProxy alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - --------------------功能函数--------------------
// 调用AFNetworking
- (NSNumber *)callAPIWithRequest:(NSURLRequest *)request
                         success:(BWCallback)success
                            fail:(BWCallback)fail {
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.httpSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchMap removeObjectForKey:requestID];
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSData *responseData = (NSData *)responseObject;
        
        // 组装成BWURLResponse后进行成功或失败回调
        if (error) {
            // 服务Response日志
            [BWLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:[NSJSONSerialization JSONObjectWithData:responseData options:NSUTF8StringEncoding error:NULL]
                                       request:request
                                         error:error];
            // 失败回调
            BWURLResponse *urlResponse = [[BWURLResponse alloc] initWithResponseData:responseData
                                                                           requestID:requestID
                                                                             request:request
                                                                               error:error];
            fail(urlResponse);
        } else {
            // 服务Response日志
            [BWLogger logDebugInfoWithResponse:httpResponse
                                 resposeString:[NSJSONSerialization JSONObjectWithData:responseData options:NSUTF8StringEncoding error:NULL]
                                       request:request
                                         error:error];
            // 成功回调
            BWURLResponse *urlResponse = [[BWURLResponse alloc] initWithResponseData:responseData
                                                                           requestID:requestID
                                                                             request:request
                                                                              status:BWURLResponseStatusSuccess];
            success(urlResponse);
        }
    }];
    
    NSNumber *requestID = @([dataTask taskIdentifier]);
    [self.dispatchMap setObject:dataTask forKey:requestID];
    [dataTask resume];
    
    return requestID;
}

#pragma mark - --------------------代理方法--------------------

#pragma mark - --------------------属性相关--------------------

- (AFHTTPSessionManager *)httpSessionManager {
    if (_httpSessionManager == nil) {
        _httpSessionManager = [AFHTTPSessionManager manager];
        _httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _httpSessionManager.securityPolicy.allowInvalidCertificates = YES;
        _httpSessionManager.securityPolicy.validatesDomainName = NO;
    }
    
    return _httpSessionManager;
}

- (NSMutableDictionary *)dispatchMap {
    if (_dispatchMap == nil) {
        _dispatchMap = [[NSMutableDictionary alloc] init];
    }
    
    return _dispatchMap;
}

#pragma mark - --------------------接口API--------------------

- (NSInteger)callGETWithParams:(NSDictionary *)apiParams
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                       success:(BWCallback)success
                          fail:(BWCallback)fail {
    NSURLRequest *request = [[BWRequestGenerator sharedInstance] generateGETRequestWithServiceIdentifier:serviceIdentifier
                                                                                           requestParams:apiParams
                                                                                              methodName:methodName];
    NSNumber *requestID = [self callAPIWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)apiParams
              serviceIdentifier:(NSString *)serviceIdentifier
                     methodName:(NSString *)methodName
                        success:(BWCallback)success
                           fail:(BWCallback)fail {
    NSURLRequest *request = [[BWRequestGenerator sharedInstance] generatePOSTRequestWithServiceIdentifier:serviceIdentifier
                                                                                            requestParams:apiParams
                                                                                               methodName:methodName];
    NSNumber *requestID = [self callAPIWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)callPUTWithParams:(NSDictionary *)apiParams
             serviceIdentifier:(NSString *)serviceIdentifier
                    methodName:(NSString *)methodName
                       success:(BWCallback)success
                          fail:(BWCallback)fail {
    NSURLRequest *request = [[BWRequestGenerator sharedInstance] generatePUTRequestWithServiceIdentifier:serviceIdentifier
                                                                                           requestParams:apiParams
                                                                                              methodName:methodName];
    NSNumber *requestID = [self callAPIWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (NSInteger)callDELETEWithParams:(NSDictionary *)apiParams
                serviceIdentifier:(NSString *)serviceIdentifier
                       methodName:(NSString *)methodName
                          success:(BWCallback)success
                             fail:(BWCallback)fail {
    NSURLRequest *request = [[BWRequestGenerator sharedInstance] generateDELETERequestWithServiceIdentifier:serviceIdentifier
                                                                                              requestParams:apiParams
                                                                                                 methodName:methodName];
    NSNumber *requestID = [self callAPIWithRequest:request success:success fail:fail];
    return [requestID integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    NSURLSessionDataTask *requestOperation = [self.dispatchMap objectForKey:requestID];
    [requestOperation cancel];
    [self.dispatchMap removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    for (NSNumber *requestID in requestIDList) {
        [self cancelRequestWithRequestID:requestID];
    }
}
#pragma mark ----------------------退出清空--------------------

@end
