//
//  BWWebViewProgress.h
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

extern const float BWInitialProgressValue;
extern const float BWInteractiveProgressValue;
extern const float BWFinalProgressValue;

typedef void (^BWWebViewProgressBlock)(float progress);

@protocol BWWebViewProgressDelegate;



@interface BWWebViewProgress : NSObject <UIWebViewDelegate>

@property (nonatomic, weak) id<BWWebViewProgressDelegate>progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate>webViewProxyDelegate;
@property (nonatomic, copy) BWWebViewProgressBlock progressBlock;
@property (nonatomic, readonly) float progress; // 0.0..1.0

- (void)reset;

@end

@protocol BWWebViewProgressDelegate <NSObject>

- (void)webViewProgress:(BWWebViewProgress *)webViewProgress updateProgress:(float)progress;

@end
