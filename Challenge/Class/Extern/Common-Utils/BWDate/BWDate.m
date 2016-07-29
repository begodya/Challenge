//
//  BWDate.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWDate.h"

@implementation BWDate

+ (NSString *)stringFromDate:(NSDate *)date formatType:(SIMPLEFORMATTYPE)type {
    NSString *dateString = @"";
    NSString *typeString = @"";
    switch (type) {
        case SIMPLEFORMATTYPE1:
            typeString = SIMPLEFORMATTYPESTRING1;
            break;
        case SIMPLEFORMATTYPE2:
            typeString = SIMPLEFORMATTYPESTRING2;
            break;
        case SIMPLEFORMATTYPE3:
            typeString = SIMPLEFORMATTYPESTRING3;
            break;
        case SIMPLEFORMATTYPE4:
            typeString = SIMPLEFORMATTYPESTRING4;
            break;
        case SIMPLEFORMATTYPE5:
            typeString = SIMPLEFORMATTYPESTRING5;
            break;
        case SIMPLEFORMATTYPE6:
            typeString = SIMPLEFORMATTYPESTRING6;
            break;
        case SIMPLEFORMATTYPE7:
            typeString = SIMPLEFORMATTYPESTRING7;
            break;
        case SIMPLEFORMATTYPE8:
            typeString = SIMPLEFORMATTYPESTRING8;
            break;
        case SIMPLEFORMATTYPE9:
            typeString = SIMPLEFORMATTYPESTRING9;
            break;
        case SIMPLEFORMATTYPE10:
            typeString = SIMPLEFORMATTYPESTRING10;
            break;
        case SIMPLEFORMATTYPE11:
            typeString = SIMPLEFORMATTYPESTRING11;
            break;
        case SIMPLEFORMATTYPE12:
            typeString = SIMPLEFORMATTYPESTRING12;
            break;
        case SIMPLEFORMATTYPE13:
            typeString = SIMPLEFORMATTYPESTRING13;
            break;
        case SIMPLEFORMATTYPE14:
            typeString = SIMPLEFORMATTYPESTRING14;
            break;
        case SIMPLEFORMATTYPE15:
            typeString = SIMPLEFORMATTYPESTRING15;
            break;
        case SIMPLEFORMATTYPE16:
            typeString = SIMPLEFORMATTYPESTRING16;
            break;
        case SIMPLEFORMATTYPE17:
            typeString = SIMPLEFORMATTYPESTRING17;
            break;
        case SIMPLEFORMATTYPE18:
            typeString = SIMPLEFORMATTYPESTRING18;
            break;
        case SIMPLEFORMATTYPE19:
            typeString = SIMPLEFORMATTYPESTRING19;
            break;
        case SIMPLEFORMATTYPE20:
            typeString = SIMPLEFORMATTYPESTRING20;
            break;
        case SIMPLEFORMATTYPE21:
            typeString = SIMPLEFORMATTYPESTRING21;
            break;
        default:
            break;
    }
    
    if (typeString.length > 0 && date != nil) {
        NSDateFormatter *dateFormatter = [BWDate currentDteFormater];
        [dateFormatter setDateFormat:typeString];
        dateString = [dateFormatter stringFromDate:date];
    }
    
    return dateString;
}

+ (NSString *)currentLogTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:SIMPLEFORMATTYPESTRING17];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDateFormatter *)currentDteFormater {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    return dateFormatter;
}

@end
