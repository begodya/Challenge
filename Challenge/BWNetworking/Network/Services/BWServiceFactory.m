//
//  BWServiceFactory.m
//  Challenge
//
//  Created by 王貝 on 7/27/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWServiceFactory.h"
#import "BWCommonService.h"

@interface BWServiceFactory()

@property (nonatomic, strong) NSMutableDictionary *serviceMap;

@end

@implementation BWServiceFactory

#pragma mark - --------------------System--------------------

+ (instancetype)sharedInstance {
    static BWServiceFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWServiceFactory alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - --------------------功能函数--------------------

- (BWService<BWServiceDelegate> *)getServiceWithIdentifier:(NSString *)identifier {
    if ([identifier isEqualToString:kBWCommonService]) {
        return [[BWCommonService alloc] init];
    }
    return nil;
}

#pragma mark - --------------------代理方法--------------------

#pragma mark - --------------------属性相关--------------------

- (NSMutableDictionary *)serviceMap {
    if (_serviceMap == nil) {
        _serviceMap = [[NSMutableDictionary alloc] init];
    }
    
    return _serviceMap;
}

#pragma mark - --------------------接口API--------------------

- (BWService<BWServiceDelegate> *)serviceWithIdentifier:(NSString *)identifier {
    if (self.serviceMap[identifier] == nil) {
        self.serviceMap[identifier] = [self getServiceWithIdentifier:identifier];
    }
    
    return self.serviceMap[identifier];
}

#pragma mark ----------------------退出清空--------------------

@end
