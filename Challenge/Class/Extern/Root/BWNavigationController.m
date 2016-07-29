//
//  BWNavigationController.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWNavigationController.h"
#import "BWRootViewController.h"
#import "BWH5ViewController.h"
#import <objc/message.h>

#define kGuestureViewTag 0xae42

@interface BWNavigationController () <UIGestureRecognizerDelegate> {
    CGPoint startTouch;
    CGFloat animateTime;
    BOOL dragAnimated;
}
@property (nonatomic, strong) UIImageView *lastScreenShotView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) NSMutableArray *screenShotsList;
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, assign) UIViewController *toViewController;
@property (nonatomic, strong) CAGradientLayer *shadowLayer;

@end

@implementation BWNavigationController

#pragma mark - --------------------初始化--------------------

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    BWNavigationController *navigationVC = [self initWithNibName:@"BWNavigationController" bundle:nil];
    [navigationVC setViewControllers:[NSArray arrayWithObject:rootViewController]];
    return navigationVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    self.screenShotsList = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.screenShotsList == NULL) {
        self.screenShotsList = [[NSMutableArray alloc] initWithCapacity:2];
    }
    
#ifdef SYSTEM_GESTURE
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
#endif
    
#ifdef CUSTOM_GESTURE
    UIPanGestureRecognizer *panGuesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(paningGestureReceive:)];
    [panGuesture delaysTouchesBegan];
    UIView *gestureView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 15, self.view.bounds.size.height)];
    [gestureView addGestureRecognizer:panGuesture];
    gestureView.tag = kGuestureViewTag;
    [self.view addSubview:gestureView];
    
    animateTime = 0.3;
    
    self.canDragBack = YES;
#endif
}

#pragma mark - --------------------代理方法--------------------

#pragma mark - --------------------接口API--------------------

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag {
    BWNavigationController *navController = [[BWNavigationController alloc] initWithRootViewController:viewControllerToPresent];
    [super presentViewController:navController animated:flag completion:nil];
}

#pragma mark - --------------------手势事件--------------------

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIImage *capturedImg = [self captureSnapShot];
    if (capturedImg != NULL) {
        [self.screenShotsList addObject:capturedImg];
    }
    self.canDragBack = YES;
    dragAnimated = NO;
    viewController.hidesBottomBarWhenPushed = YES;
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
}

// get the current view screen shot
- (UIImage *)captureSnapShot {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    [self removeLastImage];
    
    if (dragAnimated) {
        animated = NO;
    }
    UIViewController *ctr = [super popViewControllerAnimated:animated];
    return ctr;
}

// remove last image
- (void)removeLastImage {
    id lastObj = [self.screenShotsList lastObject];
    if ([self.screenShotsList count] > 1) {
        [self.screenShotsList removeObject:lastObj];
    }
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x isTransaction:(BOOL)isTransaction {
    x = x>self.view.bounds.size.width?self.view.bounds.size.width:x;
    x = x<0?0:x;
    if (isTransaction) {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    }
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    self.lastScreenShotView.center = CGPointMake(x/2, self.view.center.y);
    
    CGFloat shadowWidth = 10;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0) {
        self.shadowLayer.frame = CGRectMake(x-shadowWidth, 20, shadowWidth, self.shadowLayer.frame.size.height);
    } else {
        self.shadowLayer.frame = CGRectMake(x-shadowWidth, 0, shadowWidth, self.shadowLayer.frame.size.height);
    }
    
    if (isTransaction) {
        [CATransaction commit];
    }
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer {
    if (self.viewControllers.count <= 1 || !self.canDragBack) {
        return;
    }
    
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        self.view.userInteractionEnabled = NO;
        _isMoving = YES;
        startTouch = touchPoint;
        [self addBackgroundMaskView];
    }
    else if (recoginzer.state == UIGestureRecognizerStateEnded) {
        self.view.userInteractionEnabled = YES;
        CGFloat velocityX = [recoginzer velocityInView:self.view].x;
        
        if (velocityX < 200) {
            animateTime = 0.3;
        } else {
            animateTime = 0.2;
        }
        
        if (touchPoint.x - startTouch.x > self.view.frame.size.width/3) {
            
            CGFloat x = self.view.frame.size.width;
            [self addShadowLayerIfNeed];
            
            [UIView animateWithDuration:animateTime animations:^{
                [self moveViewWithX:x isTransaction:NO];
            } completion:^(BOOL finished){
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                dragAnimated = YES;
                
                BOOL isUseCTRootBackItem = [self shouldInvokeCTRootBackItem];
                
                if (!isUseCTRootBackItem) {
                    [self popViewControllerAnimated:NO];
                }
                
                dragAnimated = NO;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [self restorePopAction];
        }
        return;
    }
    else if (recoginzer.state == UIGestureRecognizerStateCancelled) {
        self.view.userInteractionEnabled = YES;
        [self restorePopAction];
        return;
    }
    else {
        if (_isMoving) {
            if (touchPoint.x - startTouch.x > (self.view.frame.size.width/6)) {
                if ([self shouldCancelDragAction]) {
                    return;
                }
            }
            
            [self addShadowLayerIfNeed];
            [self moveViewWithX:touchPoint.x - startTouch.x isTransaction:YES];
            
        }
    }
}

#pragma mark - Gesture Recognizer -

- (void)addBackgroundMaskView {
    CGRect frame = self.view.bounds;
    
    if (!self.backgroundView) {
        self.backgroundView = [[UIView alloc]initWithFrame:frame];
        [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
    }
    
    self.backgroundView.hidden = NO;
    
    if (self.lastScreenShotView == NULL) {
        self.lastScreenShotView = [[UIImageView alloc] initWithFrame:frame];
        [self.backgroundView addSubview:self.lastScreenShotView];
        self.shadowLayer = [CAGradientLayer layer];
        self.shadowLayer.startPoint = CGPointMake(1.0, 0.5);
        self.shadowLayer.frame = frame;
        self.shadowLayer.endPoint = CGPointMake(0, 0.5);
        self.shadowLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.0 alpha:0.2f] CGColor], (id)[[UIColor clearColor] CGColor], nil];
        [self.backgroundView.layer addSublayer:self.shadowLayer];
    }
    
    if ([self.screenShotsList count] > 0) {
        self.lastScreenShotView.image = [self.screenShotsList lastObject];
    }
}

- (void)addShadowLayerIfNeed {
    if ([self.backgroundView.layer.sublayers containsObject:self.shadowLayer]) {
        return;
    }
    [self.backgroundView.layer addSublayer:self.shadowLayer];
}

- (BOOL)shouldInvokeCTRootBackItem {
    BWRootViewController *tmpViewCtr = (BWRootViewController *)self.visibleViewController;
    BOOL isUseCTRootBackItem = NO;
    
    if ([tmpViewCtr isKindOfClass:[BWRootViewController class]] && ![tmpViewCtr isKindOfClass:[BWH5ViewController class]]) {
        UIBarButtonItem *backItem = self.visibleViewController.navigationItem.leftBarButtonItem;
        UIButton *backBtn = (UIButton *)[backItem customView];
        if ([backBtn isKindOfClass:[UIButton class]]) {
            NSSet *targets = [backBtn allTargets];
            for (id target in targets) {
                NSArray *actions = [backBtn actionsForTarget:target forControlEvent:UIControlEventTouchUpInside];
                for (NSString *actionName in actions) {
                    SEL selector = NSSelectorFromString(actionName);
                    if (selector != NULL) {
                        isUseCTRootBackItem = YES;
                        int (*action)(id, SEL, int) = (int (*)(id, SEL, int)) objc_msgSend;
                        action(target, selector, 0);
//                      objc_msgSend(target, selector, backBtn);
                    }
                }
            }
        }
    }
    
    return isUseCTRootBackItem;
}

- (void)restorePopAction {
    [self.shadowLayer removeFromSuperlayer];
    [UIView animateWithDuration:animateTime animations:^{
        [self moveViewWithX:0 isTransaction:NO];
    } completion:^(BOOL finished) {
        _isMoving = NO;
        [self.lastScreenShotView removeFromSuperview];
        self.lastScreenShotView = nil;
    }];
}

- (BOOL)shouldCancelDragAction {
    return NO;
}

@end
