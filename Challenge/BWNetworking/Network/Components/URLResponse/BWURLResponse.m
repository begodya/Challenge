//
//  BWURLResponse.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWURLResponse.h"
#import "NSURLRequest+BWNetworkMethod.h"

@interface BWURLResponse()

@property (nonatomic, strong, readwrite) NSData *reponseData;
@property (nonatomic, strong, readwrite) NSNumber *requestID;
@property (nonatomic, strong, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) BWURLResponseStatus status;
@property (nonatomic, strong, readwrite) id reponseJSON;
@end

@implementation BWURLResponse

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API--------------------

- (instancetype)initWithResponseData:(NSData *)responseData
                           requestID:(NSNumber *)requestID
                             request:(NSURLRequest *)request
                              status:(BWURLResponseStatus)status {
    self = [super self];
    if (self) {
        self.reponseData = responseData;
        self.requestID = requestID;
        self.request = request;
        self.requestParams = request.requestParams;
        self.status = status;
        self.reponseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSUTF8StringEncoding error:NULL];
    }
    
    return self;
}

- (instancetype)initWithResponseData:(NSData *)responseData
                           requestID:(NSNumber *)requestID
                             request:(NSURLRequest *)request
                               error:(NSError *)error {
    self = [super self];
    if (self) {
        self.reponseData = responseData;
        self.requestID = requestID;
        self.request = request;
        self.requestParams = request.requestParams;
        self.reponseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSUTF8StringEncoding error:NULL];
        
        switch (error.code) {
            case NSURLErrorTimedOut:
                self.status = BWURLResponseStatusErrorTimeout;
                break;
                
            default:
                self.status = BWURLResponseStatusErrorNoNetwork;
                break;
        }
    }
    
    return self;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super self];
    if (self) {
        self.reponseData = [data copy];
        self.requestID = 0;
        self.request = nil;
        self.requestParams = nil;
        self.reponseJSON = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSUTF8StringEncoding
                                                             error:NULL];
        self.status = BWURLResponseStatusSuccess;
    }
    
    return self;
}
#pragma mark ----------------------退出清空--------------------

@end
