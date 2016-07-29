//
//  BWAPIBaseManager.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWAPIBaseManager.h"
#import "BWAPIProxy.h"
#import "BWCache.h"
#import "MBProgressHUD.h"
#import "BWLogger.h"
#import "BWServiceFactory.h"
#import "BWNetwork.h"

@interface BWAPIBaseManager()
@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, assign, readwrite) BWAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIDList;
@property (nonatomic, strong) BWCache *cache;
@end

@implementation BWAPIBaseManager

#pragma mark - --------------------System--------------------
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(BWAPIManagerDelegate)]) {
            self.child = (id <BWAPIManagerDelegate>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    
    return self;
}

#pragma mark - --------------------功能函数--------------------

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestID = 0;
    NSDictionary *apiParams = [self reformParams:params];
    
    // 拦截器：进行调用前参数检查
    if ([self beforeCallAPIWithParams:apiParams]) {
        // 验证器：验证参数是否合法
        if ([self isCorrectWithParamsData:apiParams]) {
            // 检查缓存
            if (self.child.shouldCache && [self hasCacheWithParams:apiParams]) {
                return requestID;
            }
            // 网络请求入口
            if ([BWAppContext sharedInstance].isReachable) {
                requestID = [self startCallAPIWithRequestParams:apiParams];
                
                // 拦截器：进行调用后参数检查
                NSMutableDictionary *params = [apiParams mutableCopy];
                [params setObject:@(requestID) forKey:kBWAPIBaseManagerRequestID];
                [self afterCallAPIWithParamas:params];
            } else {
                [self failedOnCallingAPIWithResponse:nil andErrorType:BWAPIManagerErrorTypeNoNetWork];
                return requestID;
            }
        } else {
            [self failedOnCallingAPIWithResponse:nil andErrorType:BWAPIManagerErrorTypeParamsError];
            return requestID;
        }
    }
    
    return requestID;
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:self.child.serviceIdentifier
                                                           methodName:self.child.methodName
                                                        requestParams:params];
    if (result != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BWURLResponse *response = [[BWURLResponse alloc] initWithData:result];
            response.requestParams = params;
            [BWLogger logDebugInfoWithCachedResponse:response
                                             service:[[BWServiceFactory sharedInstance] serviceWithIdentifier:self.child.serviceIdentifier]
                                             apiName:self.child.methodName];
            [self succeededOnCallingAPIWithResponse:response];
        });
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)startCallAPIWithRequestParams:(NSDictionary *)requestParams {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        if (self.child.shouldLoading) {
            [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
        }
    });
    
    
    NSInteger requestID = 0;
    switch (self.child.requestType) {
        case BWAPIManagerRequestTypeGet: {
            __weak typeof(self) weakSelf = self;
            requestID = [[BWAPIProxy sharedInstance] callGETWithParams:requestParams serviceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName success:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf succeededOnCallingAPIWithResponse:response];
            } fail:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf failedOnCallingAPIWithResponse:response andErrorType:BWAPIManagerErrorTypeDefault];
            }];
        }
            break;
        case BWAPIManagerRequestTypePost: {
            __weak typeof(self) weakSelf = self;
            requestID = [[BWAPIProxy sharedInstance] callPOSTWithParams:requestParams serviceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName success:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf succeededOnCallingAPIWithResponse:response];
            } fail:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf failedOnCallingAPIWithResponse:response andErrorType:BWAPIManagerErrorTypeDefault];
            }];
        }
            break;
        case BWAPIManagerRequestTypePut: {
            __weak typeof(self) weakSelf = self;
            requestID = [[BWAPIProxy sharedInstance] callPUTWithParams:requestParams serviceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName success:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf succeededOnCallingAPIWithResponse:response];
            } fail:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf failedOnCallingAPIWithResponse:response andErrorType:BWAPIManagerErrorTypeDefault];
            }];
        }
            break;
        case BWAPIManagerRequestTypeDelete: {
            __weak typeof(self) weakSelf = self;
            requestID = [[BWAPIProxy sharedInstance] callDELETEWithParams:requestParams serviceIdentifier:self.child.serviceIdentifier methodName:self.child.methodName success:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf succeededOnCallingAPIWithResponse:response];
            } fail:^(BWURLResponse *response) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf failedOnCallingAPIWithResponse:response andErrorType:BWAPIManagerErrorTypeDefault];
            }];
        }
            break;
        default:
            break;
    }
    [self.requestIDList addObject:@(requestID)];
    return requestID;
}

- (void)succeededOnCallingAPIWithResponse:(BWURLResponse *)response {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (self.child.shouldLoading) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        }
    });
    self.response = response;
    
    // 服务从队列中移除
    [self removeRequestWithRequestID:[response.requestID integerValue]];
    
    // 参数验证器：服务调用成功后
    if ([self isCorrectWithCallbackData:response.reponseJSON]) {
        // 数据缓存
        if (self.child.shouldCache) {
            [self.cache saveCacheWithData:response.reponseData
                        serviceIdentifier:self.child.serviceIdentifier
                               methodName:self.child.methodName
                            requestParams:response.requestParams];
        }
        
        // 拦截器
        if ([self beforePerformSuccessWithResponse:response]) {
            [self.callbackDelegate managerCallAPISucceeded:self];
        }
        
        [self afterPerformSuccessWithResponse:response];
    } else {
        [self failedOnCallingAPIWithResponse:response andErrorType:BWAPIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPIWithResponse:(BWURLResponse *)response andErrorType:(BWAPIManagerErrorType)errorType {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (self.child.shouldLoading) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        }
    });
    
    self.response = response;
    self.errorType = errorType;
    
    // 服务从队列中移除
    [self removeRequestWithRequestID:[response.requestID integerValue]];
    
    if ([self beforePerformFailWithResponse:response]) {
        [self.callbackDelegate managerCallAPIFailed:self];
    }
    [self afterPerformFailWithResponse:response];
}

#pragma mark - 取消服务
- (void)removeRequestWithRequestID:(NSInteger)requestID {
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestID in self.requestIDList) {
        if ([storedRequestID integerValue] == requestID) {
            requestIDToRemove = storedRequestID;
        }
    }
    [self.requestIDList removeObject:requestIDToRemove];
}

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - 拦截器interceptor内部方法
- (BOOL)beforeCallAPIWithParams:(NSDictionary *)params {
    BOOL result = YES;
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:beforeCallAPIWithParams:)]) {
        result = [self.interceptorDelegate manager:self beforeCallAPIWithParams:params];
    }
    return result;
}

- (void)afterCallAPIWithParamas:(NSDictionary *)params {
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:afterCallAPIWithParamas:)]) {
        [self.interceptorDelegate manager:self afterCallAPIWithParamas:params];
    }
}

- (BOOL)beforePerformSuccessWithResponse:(BWURLResponse *)response {
    BOOL result = YES;
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:beforePerformSuccessWithResponse:)]) {
        result = [self.interceptorDelegate manager:self beforePerformSuccessWithResponse:response];
    }
    return result;
}

- (void)afterPerformSuccessWithResponse:(BWURLResponse *)response {
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        [self.interceptorDelegate manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(BWURLResponse *)response {
    BOOL result = YES;
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        result = [self.interceptorDelegate manager:self beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(BWURLResponse *)response {
    if (self.interceptorDelegate && [self.interceptorDelegate respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        [self.interceptorDelegate manager:self afterPerformFailWithResponse:response];
    }
}

#pragma mark - 参数验证器
- (BOOL)isCorrectWithParamsData:(NSDictionary *)data {
    BOOL result = YES;
    if (self.validatorDelegate && [self.validatorDelegate respondsToSelector:@selector(manager:isCorrectWithParamsData:)]) {
        result = [self.validatorDelegate manager:self isCorrectWithParamsData:data];
    }
    return result;
}

- (BOOL)isCorrectWithCallbackData:(NSDictionary *)data {
    BOOL result = YES;
    if (self.validatorDelegate && [self.validatorDelegate respondsToSelector:@selector(mamager:isCorrectWithCallbackData:)]) {
        result = [self.validatorDelegate mamager:self isCorrectWithCallbackData:data];
    }
    
    return result;
}

#pragma mark - --------------------属性相关--------------------

- (NSMutableArray *)requestIDList {
    if (_requestIDList == nil) {
        _requestIDList = [[NSMutableArray alloc] init];
    }
    
    return _requestIDList;
}

- (BWCache *)cache {
    if (_cache == nil) {
        _cache = [BWCache sharedInstance];
    }
    
    return _cache;
}

#pragma mark - --------------------接口API--------------------

// 加载参数数据
- (NSInteger)loadParams {
    NSDictionary *params = [self.paramSourcesDelegate paramsForAPI:self];
    NSInteger requestID = [self loadDataWithParams:params];
    return requestID;
}

// 通过改造器获取适合页面类型的数据
- (id)fetchDataWithReformer:(id<BWAPIManagerDataReformerDelegate>)reformer {
    return nil;
}

// 取消请求操作
- (void)cancelAllRequests {
    [[BWAPIProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIDList];
    [self.requestIDList removeAllObjects];
}

// 根据ID取消对应服务
- (void)cancelRequestWithID:(NSInteger)requestID {
    [[BWAPIProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
    [self removeRequestWithRequestID:requestID];
}

// 如果子类中覆盖这个函数就不需要调用父类方法
- (NSDictionary *)reformParams:(NSDictionary *)params {
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        NSDictionary *result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

#pragma mark ----------------------退出清空--------------------
- (void)dealloc {
    [self cancelAllRequests];
    [self.requestIDList removeAllObjects];
}

@end
