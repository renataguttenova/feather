//
//  RequestManager.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "RequestManager.h"
#import "City.h"


@implementation RequestManager

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)fetchCityWithPrediction:(GMSAutocompletePrediction *)prediction withCompletion:(void (^) (City *city))completion {
    
    NSString *URLString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@", prediction.placeID, GOOGLE_PLACES_KEY];
    
    [[AFHTTPSessionManager manager] POST:URLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSArray *addressComponents = responseObject[@"result"][@"address_components"];
        NSString *cityName = [addressComponents firstObject][@"long_name"];  //TODO - Short name?
        
        //TODO - Make sure its EXACT lat and lng
        
        NSNumber *latitude = responseObject[@"result"][@"geometry"][@"location"][@"lat"];
        NSNumber *longitude = responseObject[@"result"][@"geometry"][@"location"][@"lng"];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
        
        City *city = [[City alloc] init];
        city.locationName = cityName;
        city.coordinate = coordinate;
        city.googlePlaceID = prediction.placeID;
        
        if (completion) {
            completion(city);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //TODO - Handle error
        NSLog(@"DEBUG---- Error: %@", error);
    }];
}

- (void)fetchCityWithCurrentWeatherWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletion:(void (^) (City *city))completion {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:APIXU_KEY forKey:@"key"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude] forKey:@"q"];
    
    [[AFHTTPSessionManager manager] GET:[APIXU_BASE_URL stringByAppendingString:@"current.json"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        City *city = [[City alloc] init];
        city.locationName = responseObject[@"location"][@"name"];
        city.tempC = responseObject[@"current"][@"temp_c"];
        city.coordinate = coordinate;
        
        if (completion) {
            completion(city);
        }
                
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

- (void)updateCityWithCurrentWeather:(City *)city withCompletion:(void (^) (void))completion {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:APIXU_KEY forKey:@"key"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", city.coordinate.latitude, city.coordinate.longitude] forKey:@"q"];
    
    [[AFHTTPSessionManager manager] GET:[APIXU_BASE_URL stringByAppendingString:@"current.json"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        city.tempC = responseObject[@"current"][@"temp_c"];
        
        if (completion) {
            completion();
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

@end
