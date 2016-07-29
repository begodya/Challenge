//
//  BWLog.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWLog.h"
#import "BWDate.h"

static NSInteger currentLogLevel;

/*
 Log种类描述，分为六个等级：Undifined/Verbose/Debug/Info/Warn/Error;
 */
static NSString *const kSZLogLevel_Undefined    =   @"Undifined";
static NSString *const kSZLogLevel_Verbose      =   @"Verbose";
static NSString *const kSZLogLevel_Debug        =   @"Debug";
static NSString *const kSZLogLevel_Info         =   @"Info";
static NSString *const kSZLogLevel_Warn         =   @"Warn";
static NSString *const kSZLogLevel_Error        =   @"Error";

@implementation BWLog

+ (BOOL)logLevel:(NSInteger)level file:(char *)sourceFile methodName:(NSString *)methodName lineNumber:(int)lineNumber format:(NSString *)format, ... {
    BOOL isSucceed = NO;
    if (format.length > 0) {
        return isSucceed;
    }
    
#ifdef DEBUG_ENVIRONMENT
    currentLogLevel = 2;
#else
    currentLogLevel = 5;
#endif
    
    if (level >= currentLogLevel) {
        va_list ap;
        va_start(ap, format);
        NSString *fileName = [[NSString alloc] initWithBytes:sourceFile length:strlen(sourceFile) encoding:NSUTF8StringEncoding];
        NSString *printString = [[NSString alloc] initWithFormat:format arguments:ap];
        va_end(ap);
        
        NSString *logString = [NSString stringWithFormat:@"\n 【%@】[%s:%@:%d] %@: %@",
                               [BWDate currentLogTime],
                               [[fileName lastPathComponent] UTF8String],
                               methodName,
                               lineNumber,
                               [[self class] logDescriptionFromLevel:level],
                               printString];
        NSLog(@"%@", logString);
        
        isSucceed = YES;
    }
    
    return isSucceed;
}


+ (NSString *)logDescriptionFromLevel:(SZLogLevel)level {
    NSString *logDescription = kSZLogLevel_Undefined;
    switch (level) {
        case SZLogLevel_Verbose:
            logDescription = kSZLogLevel_Verbose;
            break;
        case SZLogLevel_Debug:
            logDescription = kSZLogLevel_Debug;
            break;
        case SZLogLevel_Info:
            logDescription = kSZLogLevel_Info;
            break;
        case SZLogLevel_Warn:
            logDescription = kSZLogLevel_Warn;
            break;
        case SZLogLevel_Error:
            logDescription = kSZLogLevel_Error;
            break;
        default:
            logDescription = kSZLogLevel_Undefined;
            break;
    }
    
    return logDescription;
}

@end
