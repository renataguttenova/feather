//
//  City.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "City.h"

@implementation City

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.locationName = dict[@"location"][@"name"];
        self.tempC = dict[@"current"][@"temp_c"];
        self.tempCString = [NSString stringWithFormat:@"%@°", self.tempC];
        self.simpleDescription = dict[@"current"][@"condition"][@"text"];
    }
    return self;
}


@end
