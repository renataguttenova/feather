//
//  ForecastViewController.h
//  Feather
//
//  Created by Renata Guttenová on 05/06/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface ForecastViewController : UIViewController

@property (strong, nonatomic) NSArray *days;
@property (strong, nonatomic) City *city;

@end
