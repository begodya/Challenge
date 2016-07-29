//
//  BWAPIBaseManager.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWURLResponse.h"
@class BWAPIBaseManager;

static NSString * const kBWAPIBaseManagerRequestID = @"kBWAPIBaseManagerRequestID";

typedef NS_ENUM (NSUInteger, BWAPIManagerErrorType){
    BWAPIManagerErrorTypeDefault,       // 没有产生过API请求，这个是manager的默认状态
    BWAPIManagerErrorTypeSuccess,       // API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的
    BWAPIManagerErrorTypeNoContent,     // API请求成功但返回数据不正确（如果回调数据验证函数返回值为NO，manager的状态就会是这个）
    BWAPIManagerErrorTypeParamsError,   // 参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的
    BWAPIManagerErrorTypeTimeout,       // 请求超时。BWAPIProxy设置的是20秒超时
    BWAPIManagerErrorTypeNoNetWork      // 网络不通。在调用API之前会判断当前网络是否通畅
};

typedef NS_ENUM (NSUInteger, BWAPIManagerRequestType){
    BWAPIManagerRequestTypeGet,         // GET
    BWAPIManagerRequestTypePost,        // POST
    BWAPIManagerRequestTypePut,         // PUT
    BWAPIManagerRequestTypeDelete       // DELETE
};


/*************************************************************************************************/
/*                                 BWAPIManagerCallbackDelegate                                  */
/*************************************************************************************************/
#pragma mark - API成功和失败回调（必选）
@protocol BWAPIManagerCallbackDelegate <NSObject>

@required
- (void)managerCallAPISucceeded:(BWAPIBaseManager *)manager;
- (void)managerCallAPIFailed:(BWAPIBaseManager *)manager;

@end


/*************************************************************************************************/
/*                              BWAPIManagerParamSourceDelegate                                  */
/*************************************************************************************************/
#pragma mark - API参数获取（必选）
@protocol BWAPIManagerParamSourceDelegate <NSObject>

@required
- (NSDictionary *)paramsForAPI:(BWAPIBaseManager *)manager;

@end


/*************************************************************************************************/
/*                              BWAPIManagerValidatorDelegate                                    */
/*************************************************************************************************/
#pragma mark - API参数及返回数据验证（必选）
@protocol BWAPIManagerValidatorDelegate <NSObject>

@required
- (BOOL)manager:(BWAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
- (BOOL)mamager:(BWAPIBaseManager *)manager isCorrectWithCallbackData:(NSDictionary *)data;

@end


/*************************************************************************************************/
/*                            BWAPIManagerInterceptorDelegate                                    */
/*************************************************************************************************/
#pragma mark - API拦截验证（可选）
@protocol BWAPIManagerInterceptorDelegate <NSObject>

@optional
- (BOOL)manager:(BWAPIBaseManager *)manager beforeCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(BWAPIBaseManager *)manager afterCallAPIWithParamas:(NSDictionary *)params;

- (BOOL)manager:(BWAPIBaseManager *)manager beforePerformSuccessWithResponse:(BWURLResponse *)response;
- (void)manager:(BWAPIBaseManager *)manager afterPerformSuccessWithResponse:(BWURLResponse *)response;

- (BOOL)manager:(BWAPIBaseManager *)manager beforePerformFailWithResponse:(BWURLResponse *)response;
- (void)manager:(BWAPIBaseManager *)manager afterPerformFailWithResponse:(BWURLResponse *)response;

@end


/*************************************************************************************************/
/*                            BWAPIManagerDataReformerDelegate                                   */
/*************************************************************************************************/
#pragma mark - API返回数据改造器（必选）
@protocol BWAPIManagerDataReformerDelegate <NSObject>

@required
- (id)manager:(BWAPIBaseManager *)manager reformData:(NSDictionary *)data;

@end


/*************************************************************************************************/
/*                                    BWAPIManagerDelegate                                       */
/*************************************************************************************************/
#pragma mark - API派生类
@protocol BWAPIManagerDelegate <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceIdentifier;
- (BWAPIManagerRequestType)requestType;
- (BOOL)shouldCache;
- (BOOL)shouldLoading;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;

@end





/*************************************************************************************************/
/*                                       BWAPIBaseManager                                        */
/*************************************************************************************************/
#pragma mark - API管理器
@interface BWAPIBaseManager : NSObject

@property (nonatomic, weak) id<BWAPIManagerCallbackDelegate> callbackDelegate;
@property (nonatomic, weak) id<BWAPIManagerParamSourceDelegate> paramSourcesDelegate;
@property (nonatomic, weak) id<BWAPIManagerValidatorDelegate> validatorDelegate;
@property (nonatomic, weak) id<BWAPIManagerInterceptorDelegate> interceptorDelegate;
@property (nonatomic, weak) NSObject<BWAPIManagerDelegate> *child;

@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, assign, readonly) BWAPIManagerErrorType errorType;
@property (nonatomic, strong) BWURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

// 加载参数数据
- (NSInteger)loadParams;

// 通过改造器获取适合页面类型的数据
- (id)fetchDataWithReformer:(id<BWAPIManagerDataReformerDelegate>)reformer;

// 取消请求操作
- (void)cancelAllRequests;
- (void)cancelRequestWithID:(NSInteger)requestID;

// 组合已有参数
//- (NSDictionary *)reformParams:(NSDictionary *)params;

@end
