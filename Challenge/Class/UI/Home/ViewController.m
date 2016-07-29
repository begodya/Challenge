//
//  ViewController.m
//  Challenge
//
//  Created by 王貝 on 7/23/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "ViewController.h"
#import "BWAPIBaseManager.h"
#import "HomeAPIManager.h"

@interface ViewController () <BWAPIManagerParamSourceDelegate, BWAPIManagerCallbackDelegate>

@property (nonatomic, strong) HomeAPIManager *homeAPIManager;

@end

@implementation ViewController

#pragma mark - --------------------System--------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.homeAPIManager loadParams];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --------------------功能函数--------------------

#pragma mark - --------------------手势事件--------------------

#pragma mark - --------------------按钮事件--------------------

#pragma mark - --------------------代理方法--------------------

#pragma mark - BWAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForAPI:(BWAPIBaseManager *)manager {
    NSDictionary *params = @{};
    
    if (_homeAPIManager == manager) {
        params = @{
                   kLatitude:@(31.228000),
                   kLongitude:@(121.454290)
                   };
    }
    
    return params;
}

#pragma mark - BWAPIManagerCallbackDelegate

#pragma mark - --------------------属性相关--------------------
- (HomeAPIManager *)homeAPIManager {
    if (_homeAPIManager == nil) {
        _homeAPIManager = [[HomeAPIManager alloc] init];
        _homeAPIManager.paramSourcesDelegate = self;
        _homeAPIManager.callbackDelegate = self;
    }
    
    return _homeAPIManager;
}

#pragma mark - BWAPIManagerCallbackDelegate
- (void)managerCallAPISucceeded:(BWAPIBaseManager *)manager {
    
}

- (void)managerCallAPIFailed:(BWAPIBaseManager *)manager {
    
}

#pragma mark - --------------------接口API--------------------

#pragma mark ----------------------退出清空--------------------

@end
