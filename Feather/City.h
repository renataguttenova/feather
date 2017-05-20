//
//  City.h
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (strong, nonatomic) NSString *locationName;
@property (strong, nonatomic) NSNumber *tempC;
@property (strong, nonatomic) NSString *tempCString;
@property (strong, nonatomic) NSString *simpleDescription;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
