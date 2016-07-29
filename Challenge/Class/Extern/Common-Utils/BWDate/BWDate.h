//
//  BWDate.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SIMPLEFORMATTYPE1   = 1,
    SIMPLEFORMATTYPE2   = 2,
    SIMPLEFORMATTYPE3   = 3,
    SIMPLEFORMATTYPE4   = 4,
    SIMPLEFORMATTYPE5   = 5,
    SIMPLEFORMATTYPE6   = 6,
    SIMPLEFORMATTYPE7   = 7,
    SIMPLEFORMATTYPE8   = 8,
    SIMPLEFORMATTYPE9   = 9,
    SIMPLEFORMATTYPE10  = 10,
    SIMPLEFORMATTYPE11  = 11,
    SIMPLEFORMATTYPE12  = 12,
    SIMPLEFORMATTYPE13  = 13,
    SIMPLEFORMATTYPE14  = 14,
    SIMPLEFORMATTYPE15  = 15,
    SIMPLEFORMATTYPE16  = 16,
    SIMPLEFORMATTYPE17  = 17,
    SIMPLEFORMATTYPE18  = 18,
    SIMPLEFORMATTYPE19  = 19,
    SIMPLEFORMATTYPE20  = 20,
    SIMPLEFORMATTYPE21,
}SIMPLEFORMATTYPE;

/*
 SIMPLEFORMATTYPESTRING1 对应的类型：yyyyMMddHHmmss
 */
static NSString *SIMPLEFORMATTYPESTRING1  = @"yyyyMMddHHmmss";

/*
 SIMPLEFORMATTYPESTRING2 对应的类型：yyyy-MM-dd HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING2  = @"yyyy-MM-dd HH:mm:ss";

/*
 SIMPLEFORMATTYPESTRING3 对应的类型：yyyy-M-d HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING3  = @"yyyy-M-d HH:mm:ss";

/*
 SIMPLEFORMATTYPESTRING4 对应的类型：yyyy-MM-dd HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING4  = @"yyyy-MM-dd HH:mm";

/*
 SIMPLEFORMATTYPESTRING5 对应的类型：yyyy-M-d HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING5  = @"yyyy-M-d HH:mm";

/*
 SIMPLEFORMATTYPESTRING6 对应的类型：yyyyMMdd
 */
static NSString *SIMPLEFORMATTYPESTRING6  = @"yyyyMMdd";

/*
 SIMPLEFORMATTYPESTRING7 对应的类型：yyyy-MM-dd
 */
static NSString *SIMPLEFORMATTYPESTRING7  = @"yyyy-MM-dd";

/*
 SIMPLEFORMATTYPESTRING8 对应的类型：yyyy-M-d
 */
static NSString *SIMPLEFORMATTYPESTRING8  = @"yyyy-M-d";

/*
 SIMPLEFORMATTYPESTRING9 对应的类型：yyyy年MM月dd日
 */
static NSString *SIMPLEFORMATTYPESTRING9  = @"yyyy年MM月dd日";

/*
 SIMPLEFORMATTYPESTRING10 对应的类型：yyyy年M月d日
 */
static NSString *SIMPLEFORMATTYPESTRING10  = @"yyyy年M月d日";

/*
 SIMPLEFORMATTYPESTRING11 对应的类型：M月d日
 */
static NSString *SIMPLEFORMATTYPESTRING11  = @"M月d日";

/*
 SIMPLEFORMATTYPESTRING12 对应的类型：HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING12  = @"HH:mm:ss";

/*
 SIMPLEFORMATTYPESTRING13 对应的类型：HH:mm
 */
static NSString *SIMPLEFORMATTYPESTRING13  = @"HH:mm";

/*
 SIMPLEFORMATTYPESTRING14 对应的类型：MM/dd/yyyy
 */
static NSString *SIMPLEFORMATTYPESTRING14  = @"MM/dd/yyyy";

/*
 SIMPLEFORMATTYPESTRING15 对应的类型：yyyy年MM月
 */
static NSString *SIMPLEFORMATTYPESTRING15  = @"yyyy年MM月";

/*
 SIMPLEFORMATTYPESTRING16 对应的类型：yyyyMMddHHmmssSSS
 */
static NSString *SIMPLEFORMATTYPESTRING16  = @"yyyyMMddHHmmssSSS";

/*
 SIMPLEFORMATTYPESTRING17 对应的类型：yyyy-MM-dd HH:mm:ss.SSS
 */
static NSString *SIMPLEFORMATTYPESTRING17  = @"yyyy-MM-dd HH:mm:ss.SSS";

/*
 SIMPLEFORMATTYPESTRING18 对应的类型：yyyy/MM/dd HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING18  = @"yyyy/MM/dd HH:mm:ss";

/*
 SIMPLEFORMATTYPESTRING19 对应的类型：MM/dd/yyyy HH:mm:ss
 */
static NSString *SIMPLEFORMATTYPESTRING19  = @"MM/dd/yyyy HH:mm:ss";

/*
 SIMPLEFORMATTYPESTRING20 对应的类型：MM-dd
 */
static NSString *SIMPLEFORMATTYPESTRING20  = @"MM-dd";

/*
 SIMPLEFORMATTYPESTRING21 对应的类型：M-d
 */
static NSString *SIMPLEFORMATTYPESTRING21  = @"M-d";





@interface BWDate : NSObject

/*
 根据SIMPLEFORMATTYPE返回对应日期的字符串格式
 */
+ (NSString *)stringFromDate:(NSDate *)date formatType:(SIMPLEFORMATTYPE)type;

/*
 获取当前日志时间字符串
 */
+ (NSString *)currentLogTime;

@end
