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
    self.contentView.backgroundColor = [UIColor grayLight];
    self.cityLabel.font = [UIFont nunitoBoldWithSize:25.0f];
    self.cityLabel.text = city.locationName;
    self.cityLabel.textColor = [UIColor grayDarkest];
    self.cityLabel.backgroundColor = [UIColor tealDark];
    self.temperatureLabel.text = [city.tempC stringValue];
    self.temperatureLabel.textColor = [UIColor grayDarkest];
    self.temperatureLabel.backgroundColor = [UIColor tealDark];
}


@end
