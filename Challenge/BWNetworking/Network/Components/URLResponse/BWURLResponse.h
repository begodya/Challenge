//
//  BWURLResponse.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BWURLResponseStatus) {
    BWURLResponseStatusSuccess,
    BWURLResponseStatusErrorTimeout,
    BWURLResponseStatusErrorNoNetwork
};

@interface BWURLResponse : NSObject

@property (nonatomic, strong, readonly) NSData *reponseData;
@property (nonatomic, strong, readonly) NSNumber *requestID;
@property (nonatomic, strong, readonly) NSURLRequest *request;
@property (nonatomic, assign, readonly) BWURLResponseStatus status;
@property (nonatomic, copy) NSDictionary *requestParams;

@property (nonatomic, strong, readonly) id reponseJSON;

/**
 *  初始化服务返回对象
 *
 *  @param responseData 返回数据
 *  @param requestID    请求ID
 *  @param request      请求对象
 *  @param status       返回状态
 *
 *  @return 服务返回对象
 */
- (instancetype)initWithResponseData:(NSData *)responseData
                           requestID:(NSNumber *)requestID
                             request:(NSURLRequest *)request
                              status:(BWURLResponseStatus)status;

/**
 *  初始化服务返回对象
 *
 *  @param responseData 返回数据
 *  @param requestID    请求ID
 *  @param request      请求对象
 *  @param error        错误对象
 *
 *  @return 服务返回对象
 */
- (instancetype)initWithResponseData:(NSData *)responseData
                           requestID:(NSNumber *)requestID
                             request:(NSURLRequest *)request
                               error:(NSError *)error;

/**
 *  初始化服务返回对象（针对缓存数据）
 *
 *  @param data 缓存数据
 *
 *  @return 服务返回对象
 */
- (instancetype)initWithData:(NSData *)data;

@end
