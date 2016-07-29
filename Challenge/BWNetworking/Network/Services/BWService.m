//
//  BWService.m
//  Challenge
//
//  Created by 王貝 on 7/27/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWService.h"

@implementation BWService

- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(BWServiceDelegate)]) {
            self.child = (id<BWServiceDelegate>)self;
        }
    }
    
    return self;
}

- (NSString *)host {
    return self.child.isOnline?self.child.onlineHost:self.child.offlineHost;
}

@end
