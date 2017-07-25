//
//  Day.h
//  Feather
//
//  Created by Renata Guttenová on 03/07/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Day : NSObject

@property (strong, nonatomic) NSString *iconCode;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSNumber *tempC;

@end
