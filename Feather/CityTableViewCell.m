//
//  CityTableViewCell.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "CityTableViewCell.h"
#import "Day.h"

@interface CityTableViewCell ()

@end

@implementation CityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithCity:(City *)city {
    self.cityLabel.text = city.locationName;
    self.temperatureLabel.text = [city.tempC stringValue];
}

- (void)configureWithDay:(Day *)day {
    self.cityLabel.text = [day.tempC stringValue];
}


@end
