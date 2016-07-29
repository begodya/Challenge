//
//  BWServiceFactory.h
//  Challenge
//
//  Created by 王貝 on 7/27/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWService.h"

static NSString * const kBWCommonService = @"kBWCommonService";

@interface BWServiceFactory : NSObject

/**
 *  服务种类工厂单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/**
 *  服务种类工厂
 *
 *  @param identifier 服务种类标识
 *
 *  @return 服务种类
 */
- (BWService<BWServiceDelegate> *)serviceWithIdentifier:(NSString *)identifier;

@end
