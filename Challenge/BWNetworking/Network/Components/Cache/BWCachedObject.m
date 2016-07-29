//
//  BWCachedObject.m
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWCachedObject.h"
#import "BWNetworkConfig.h"

@interface BWCachedObject()
@property (nonatomic, copy, readwrite) NSData *contentData;
@property (nonatomic, copy, readwrite) NSDate *lastUpdateTime;
@end

@implementation BWCachedObject

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------属性相关--------------------

- (BOOL)isEmpty {
    return self.contentData == nil;
}

- (BOOL)isOutdated {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > kBWCacheOutdateTimeSeconds;
}

- (void)setContentData:(NSData *)contentData {
    _contentData = contentData;
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - --------------------接口API--------------------

- (instancetype)initWithContentData:(NSData *)contentData {
    self = [super init];
    if (self) {
        self.contentData = contentData;
    }
    
    return self;
}

- (void)updateContentData:(NSData *)contentData {
    self.contentData = contentData;
}

#pragma mark ----------------------退出清空--------------------

@end
