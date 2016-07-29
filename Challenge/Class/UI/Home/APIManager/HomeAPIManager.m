//
//  HomeAPIManager.m
//  Challenge
//
//  Created by 王貝 on 7/26/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "HomeAPIManager.h"
#import "BWServiceFactory.h"

@implementation HomeAPIManager

#pragma mark - --------------------System--------------------
- (instancetype)init {
    self = [super init];
    if (self) {
        self.validatorDelegate = self;
        self.interceptorDelegate = self;
    }
    
    return self;
}

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - BWAPIManagerDelegate
- (NSString *)methodName {
    return @"v3/geocode/regeo";
}

- (NSString *)serviceIdentifier {
    return kBWCommonService;
}

- (BWAPIManagerRequestType)requestType {
    return BWAPIManagerRequestTypeGet;
}

- (BOOL)shouldCache {
    return YES;
}

- (BOOL)shouldLoading {
    return YES;
}

- (NSDictionary *)reformParams:(NSDictionary *)params {
    NSMutableDictionary *resultParams = [[NSMutableDictionary alloc] init];
    resultParams[@"key"] = @"384ecc4559ffc3b9ed1f81076c5f8424";
    resultParams[@"location"] = [NSString stringWithFormat:@"%@,%@", params[kLongitude], params[kLatitude]];
    resultParams[@"output"] = @"json";

    return resultParams;
}

#pragma mark - BWAPIManagerValidatorDelegate
- (BOOL)manager:(BWAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    return YES;
}

- (BOOL)mamager:(BWAPIBaseManager *)manager isCorrectWithCallbackData:(NSDictionary *)data {
    return YES;
}

#pragma mark - BWAPIManagerInterceptorDelegate
- (BOOL)manager:(BWAPIBaseManager *)manager beforeCallAPIWithParams:(NSDictionary *)params {
    return YES;
}

- (void)manager:(BWAPIBaseManager *)manager afterCallAPIWithParamas:(NSDictionary *)params {
    
}

- (BOOL)manager:(BWAPIBaseManager *)manager beforePerformSuccessWithResponse:(BWURLResponse *)response {
    return YES;
}

- (void)manager:(BWAPIBaseManager *)manager afterPerformSuccessWithResponse:(BWURLResponse *)response {
    
}

- (BOOL)manager:(BWAPIBaseManager *)manager beforePerformFailWithResponse:(BWURLResponse *)response {
    return YES;
}

- (void)manager:(BWAPIBaseManager *)manager afterPerformFailWithResponse:(BWURLResponse *)response {
    
}

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API--------------------

#pragma mark ----------------------退出清空--------------------

@end
