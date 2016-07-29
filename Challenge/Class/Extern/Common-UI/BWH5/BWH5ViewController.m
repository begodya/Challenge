//
//  BWH5ViewController.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWH5ViewController.h"
#import "BWWebView.h"
#import "UIViewController+BWNavigationBar.h"
#import "BWWebProgressView.h"
#import "BWWebViewProgress.h"

@interface BWH5ViewController () <UIWebViewDelegate, BWWebViewProgressDelegate> {
    BWWebProgressView *_progressView;
    BWWebViewProgress *_progressProxy;
}

@property (nonatomic, strong) NSURL *currentURL;
@property (nonatomic, strong) BWWebView *h5WebView;

@end


@implementation BWH5ViewController

#pragma mark - --------------------System--------------------

- (id)initWithURL:(NSURL *)url {
    if (self = [super initWithNibName:NULL bundle:NULL]) {
        NSAssert(url.absoluteString.length > 5, @"URL is too short %@", url);
        
        self.currentURL = url;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.h5WebView = [[BWWebView alloc] initWithFrame:self.view.bounds];
    self.h5WebView.delegate = self;
    self.h5WebView.autoresizesSubviews = YES;
    self.h5WebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.h5WebView];
    
    // 设置加载进度条
    [self configProgressView];
    
    // 设置加载页面
    [self reloadWebPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --------------------功能函数--------------------

- (void)configProgressView
{
    _progressProxy = [[BWWebViewProgress alloc] init];
    _h5WebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    _progressView = [[BWWebProgressView alloc] init];
    [self.bwNavigationController.navigationBar addSubview:_progressView];
}

- (void)reloadWebPage {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.currentURL];
    [self.h5WebView loadRequest:request];
}

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        self.currentURL = [request URL];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 打开网络加载状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 关闭网络加载状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
    
    // 显示H5标题
    [self setCustomTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    // 关闭网络加载状态
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

#pragma mark - BWWebViewProgressDelegate
- (void)webViewProgress:(BWWebViewProgress *)webViewProgress updateProgress:(float)progress {
    // 显示进度
    [_progressView setProgress:progress animated:YES];
    
    // 显示H5标题
    [self setCustomTitle:[_h5WebView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

#pragma mark - --------------------属性相关--------------------

#pragma mark - --------------------接口API--------------------

#pragma mark ----------------------退出清空--------------------

@end







@implementation BWH5ViewController(URL)

+ (BWH5ViewController *)loadURL:(NSURL *)url fromViewController:(UIViewController *)viewController {
    return [BWH5ViewController loadURL:url title:NULL isShowToolBar:NO subClass:[BWH5ViewController class] fromViewController:viewController];
}

+ (BWH5ViewController *)loadURL:(NSURL *)url title:(NSString *)title fromViewController:(UIViewController *)viewController {
    return [BWH5ViewController loadURL:url title:title isShowToolBar:NO subClass:[BWH5ViewController class] fromViewController:viewController];
}

+ (BWH5ViewController *)presentURL:(NSURL *)url title:(NSString *)title fromViewController:(UIViewController *)viewController {
    return [BWH5ViewController presentURL:url title:title isShowToolBar:NO subClass:[BWH5ViewController class] fromViewController:viewController];
}

@end



@implementation BWH5ViewController(Private)

+ (BWH5ViewController *)loadURL:(NSURL *)url title:(NSString *)title isShowToolBar:(BOOL)isShow subClass:(Class)cls fromViewController:(UIViewController *)viewController {
    if ([cls isSubclassOfClass:[BWH5ViewController class]]) {
        BWH5ViewController *h5ViewController = [[cls alloc] initWithURL:url];
        if (title.length > 0) {
            [h5ViewController setCustomTitle:title];
        }
        
        [viewController.navigationController pushViewController:h5ViewController animated:YES];
        return h5ViewController;
    }
    
    return NULL;
}

+ (BWH5ViewController *)presentURL:(NSURL *)url title:(NSString *)title isShowToolBar:(BOOL)isShow subClass:(Class)cls fromViewController:(UIViewController *)viewController {
    if ([cls isSubclassOfClass:[BWH5ViewController class]]) {
        BWH5ViewController *h5ViewController = [[cls alloc] initWithURL:url];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:h5ViewController];
        if (title.length > 0) {
            [h5ViewController setCustomTitle:title];
        }
        
        [viewController.navigationController presentViewController:navigationController animated:YES completion:nil];
        return h5ViewController;
    }
    
    return NULL;
}

@end
