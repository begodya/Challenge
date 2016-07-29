//
//  BWWebView.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWWebView.h"

@implementation BWWebView

#pragma mark - --------------------System--------------------

#pragma mark - --------------------功能函数--------------------

- (void)setDelegate:(id<UIWebViewDelegate>)delegate {
    if (self.mDelegate != delegate) {
        [super setDelegate:(id)self];
        self.mDelegate = delegate;
    }
}

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([self.mDelegate isEqual:[NSNull null]]) {
        return YES;
    } else if ([self.mDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.mDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else if (self.mDelegate == NULL) {
        return YES;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([self.mDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.mDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if ([self.mDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.mDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    if ([self.mDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.mDelegate webView:webView didFailLoadWithError:error];
    }
}

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API--------------------

#pragma mark ----------------------退出清空--------------------

@end
