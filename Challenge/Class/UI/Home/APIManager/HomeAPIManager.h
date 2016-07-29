//
//  HomeAPIManager.h
//  Challenge
//
//  Created by 王貝 on 7/26/16.
//  Copyright © 2016 Begodya. All rights reserved.
//

#import "BWAPIBaseManager.h"

static NSString * const kLatitude = @"Latitude";
static NSString * const kLongitude = @"Longitude";

@interface HomeAPIManager : BWAPIBaseManager <BWAPIManagerDelegate, BWAPIManagerValidatorDelegate, BWAPIManagerInterceptorDelegate>

@end
