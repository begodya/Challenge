//
//  BWLog.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHConfig.h"

#ifdef DEBUG_ENVIRONMENT

#define VLog(s,...) [SZLog logLevel:SZLogLevel_Verbose file:__FILE__ methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#define DLog(s,...) [SZLog logLevel:SZLogLevel_Debug file:__FILE__ methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#define ILog(s,...) [SZLog logLevel:SZLogLevel_Info file:__FILE__ methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#define WLog(s,...) [SZLog logLevel:SZLogLevel_Warn file:__FILE__ methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#define ELog(s,...) [SZLog logLevel:SZLogLevel_Error file:__FILE__ methodName:NSStringFromSelector(_cmd) lineNumber:__LINE__ format:(s),##__VA_ARGS__]
#define CLog(format, ...) NSLog((@"%s@%d: " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define VLog(s,...)
#define DLog(s,...)
#define ILog(s,...)
#define WLog(s,...)
#define ELog(s,...)
#define CLog(format, ...)

#endif

typedef NS_ENUM(NSInteger, SZLogLevel) {
    SZLogLevel_Undefined    =  0,
    SZLogLevel_Verbose      =  1,
    SZLogLevel_Debug        =  2,
    SZLogLevel_Info         =  3,
    SZLogLevel_Warn         =  4,
    SZLogLevel_Error        =  5,
};

@interface BWLog : NSObject

+ (BOOL)logLevel:(NSInteger)level file:(char *)sourceFile methodName:(NSString *)methodName lineNumber:(int)lineNumber format:(NSString *)format, ...;

@end
