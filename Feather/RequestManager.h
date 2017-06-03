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
#import <GooglePlaces/GooglePlaces.h>


@interface RequestManager : NSObject

+ (instancetype)sharedManager;

- (void)fetchCityWithPrediction:(GMSAutocompletePrediction *)prediction withCompletion:(void (^) (City *city))completion;
- (void)fetchCityWithCurrentWeatherWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletion:(void (^) (City *city))completion;
- (void)updateCityWithCurrentWeather:(City *)city withCompletion:(void (^) (void))completion;

@end
