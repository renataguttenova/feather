//
//  CityTableViewCell.h
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "Day.h"

@interface CityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

- (void)configureWithCity:(City *)city;

@end
