//
//  RequestManager.h
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "City.h"


@interface RequestManager : NSObject

+ (instancetype)sharedManager;

- (void)requestCurrentWeatherWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletion:(void (^) (City *city))completion;

@end
