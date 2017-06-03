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

- (void)fetchPlaceDetailsWithPrediction:(GMSAutocompletePrediction *)prediction {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *URLString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@", prediction.placeID, GOOGLE_PLACES_KEY];
    
    [manager POST:URLString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)requestCurrentWeatherWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletion:(void (^) (City *city))completion {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:APIXU_KEY forKey:@"key"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude] forKey:@"q"];
    
    [[AFHTTPSessionManager manager] GET:[APIXU_BASE_URL stringByAppendingString:@"current.json"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            City *city = [[City alloc] initWithDict:responseObject]; completion(city);
        }
                
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

@end
