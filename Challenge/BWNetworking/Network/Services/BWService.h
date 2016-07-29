//
//  BWService.h
//  Challenge
//
//  Created by 王貝 on 7/27/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BWServiceDelegate <NSObject>

@property (nonatomic, assign, readonly) BOOL isOnline;

@property (nonatomic, strong, readonly) NSString *onlineHost;
@property (nonatomic, strong, readonly) NSString *offlineHost;

@end

@interface BWService : NSObject

@property (nonatomic, weak) id<BWServiceDelegate> child;
@property (nonatomic, strong, readonly) NSString *host;

@end
