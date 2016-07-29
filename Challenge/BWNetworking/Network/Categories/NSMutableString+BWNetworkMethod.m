//
//  NSMutableString+BWNetworkMethod.m
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "NSMutableString+BWNetworkMethod.h"
#import "NSObject+BWNetworkMethod.h"

@implementation NSMutableString (BWNetworkMethod)

- (void)appendURLRequest:(NSURLRequest *)request {
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] BW_defaultValue:@"\t\t\t\tN/A"]];
}

@end
