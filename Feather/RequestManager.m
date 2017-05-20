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

- (void)requestCurrentWeatherWithCoordinate:(CLLocationCoordinate2D)coordinate withCompletion:(void (^) (City *city))completion {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:APIXU_KEY forKey:@"key"];
    [params setObject:[NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude] forKey:@"q"];
    
    [SVProgressHUD show];
    
    [[AFHTTPSessionManager manager] GET:[APIXU_BASE_URL stringByAppendingString:@"current.json"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completion) {
            City *city = [[City alloc] initWithDict:responseObject]; completion(city);
        }
        
        [SVProgressHUD dismiss];
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"fail");
    }];
}

@end
