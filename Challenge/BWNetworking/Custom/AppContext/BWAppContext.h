//
//  BWAppContext.h
//  Challenge
//
//  Created by 王貝 on 7/26/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWAppContext : NSObject

@property(nonatomic, assign, readonly) BOOL isReachable;

+ (instancetype)sharedInstance;

@end
