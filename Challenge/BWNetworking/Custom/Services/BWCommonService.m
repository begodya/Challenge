//
//  BWCommonService.m
//  Challenge
//
//  Created by 王貝 on 7/27/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWCommonService.h"

@implementation BWCommonService

- (BOOL)isOnline {
    return YES;
}

- (NSString *)onlineHost {
    return @"http://restapi.amap.com/";
}

- (NSString *)offlineHost {
    return @"http://restapi.amap.com/";
}

@end
