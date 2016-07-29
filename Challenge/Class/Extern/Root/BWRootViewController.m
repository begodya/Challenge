//
//  BWRootViewController.m
//  Challenge
//
//  Created by 王貝 on 7/28/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWRootViewController.h"
#import "BWNavigationController.h"
#import "UIViewController+BWNavigationBar.h"
#import "BWFullMaskView.h"

@interface BWRootViewController () <BWFullMaskViewDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate> {
    BWFullMaskView *maskView_;
    UIWindow *applicationWindow_;
}

@end

@implementation BWRootViewController

@synthesize bwNavigationController;

#pragma mark - --------------------System--------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initBaseData];
    }
    return self;
}

- (void)initBaseData {
    applicationWindow_ = [[UIApplication sharedApplication].delegate window];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    if (self.navigationController) {
        self.bwNavigationController = (BWNavigationController *)self.navigationController;
        if ([self.bwNavigationController.viewControllers count] > 1) {
            [self setBackBarButtonWithTarget:self action:@selector(backBarButtonClicked:)];
        }
        else if ([self.bwNavigationController.viewControllers count] == 1) {
            id rootViewController = applicationWindow_.rootViewController;
            
            if ([rootViewController isKindOfClass:[BWNavigationController class]]) {
                rootViewController = ((BWNavigationController *)rootViewController).topViewController;
                // 顶层模态视图获取逻辑
                if (((BWRootViewController *)rootViewController).presentedViewController) {
                    [self setCloseBarButtonWithTarget:self action:@selector(closeBarButtonClicked:)];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.bwNavigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.bwNavigationController.delegate = nil;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark 返回按钮点击
- (void)backBarButtonClicked:(id)sender {
    if ([self.bwNavigationController.viewControllers count] > 1){
        [self.bwNavigationController popViewControllerAnimated:YES];
    }else if ([self.bwNavigationController.viewControllers count] == 1) {
        [self.bwNavigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 关闭按钮点击
- (void)closeBarButtonClicked:(id)sender {
    if ([self.bwNavigationController.viewControllers count] == 1) {
        [self.bwNavigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - BWFullMaskViewDelegate
- (void)maskView:(BWFullMaskView *)view willRemoveFromSuperView:(UIView *)superView {
    maskView_ = nil;
}

#pragma mark - --------------------接口API--------------------
- (void)showCoverViewWithContentView:(UIView *)contentView {
    [self showCoverViewWithContentView:contentView isHideWhenTouchBackground:YES];
}

- (void)showCoverViewWithContentView:(UIView *)contentView
           isHideWhenTouchBackground:(BOOL)isHide {
    [self showCoverViewWithContentView:contentView isHideWhenTouchBackground:YES backgroundAlpha:0.4 position:eCoverViewPositionTypeCenter];
}

- (void)showCoverViewWithContentView:(UIView *)contentView
                     backgroundAlpha:(CGFloat)alpha {
    [self showCoverViewWithContentView:contentView isHideWhenTouchBackground:YES backgroundAlpha:alpha position:eCoverViewPositionTypeCenter];
}

- (void)showCoverViewWithContentView:(UIView *)contentView
           isHideWhenTouchBackground:(BOOL)isHide
                     backgroundAlpha:(CGFloat)alpha
                            position:(eCoverViewPositionType)positionType {
    if (!maskView_) {
        @synchronized(self) {
            if (!maskView_) {
                maskView_ = [[BWFullMaskView alloc] initWithFrame:applicationWindow_.bounds];
                [maskView_ setDelegate:self];
                [maskView_ setAlpha:0.0f];
                [maskView_ setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
            }
        }
    } else {
        [[maskView_ subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [maskView_ setIsHideWhenTouchBackground:isHide];
    
    switch (positionType) {
        case eCoverViewPositionTypeCenter: {
            [contentView setCenter:CGPointMake(maskView_.bounds.size.width/2.0, maskView_.bounds.size.height/2.0)];
        }
            break;
        case eCoverViewPositionTypeTop: {
            [contentView setFrame:CGRectMake(0, 0, contentView.bounds.size.width, contentView.bounds.size.height)];
        }
            break;
        case eCoverViewPositionTypeBottom: {
            [contentView setFrame:CGRectMake(0, maskView_.bounds.size.height-contentView.bounds.size.height, contentView.bounds.size.width, contentView.bounds.size.height)];
        }
            break;
        case eCoverViewPositionTypeCustome: {
            
        }
            break;
            
        default:
            break;
    }
    
    [maskView_ addSubview:contentView];
    [applicationWindow_ addSubview:maskView_];
    
    [UIView animateWithDuration:.5f animations:^{
        [maskView_ setAlpha:1.0f];
    } completion:^(BOOL maskView_) {
        
    }];
}

@end
