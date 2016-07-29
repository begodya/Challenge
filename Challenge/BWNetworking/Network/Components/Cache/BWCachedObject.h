//
//  BWCachedObject.h
//  Challenge
//
//  Created by 王貝 on 7/25/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BWCachedObject : NSObject

@property (nonatomic, copy, readonly) NSData *contentData;
@property (nonatomic, copy, readonly) NSDate *lastUpdateTime;

@property (nonatomic, assign, readonly) BOOL isOutdated;
@property (nonatomic, assign, readonly) BOOL isEmpty;

/**
 *  初始化缓存
 *
 *  @param contentData 缓存数据
 *
 *  @return 缓存对象
 */
- (instancetype)initWithContentData:(NSData *)contentData;

/**
 *  缓存数据更新
 *
 *  @param contentData 缓存数据
 */
- (void)updateContentData:(NSData *)contentData;

@end
