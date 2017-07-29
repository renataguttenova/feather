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
    
    [self configure];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithCity:(City *)city andBackgroundColor:(UIColor *)color {
    self.contentView.backgroundColor = color;
    self.cityLabel.text = city.locationName;
    self.temperatureLabel.text = [[city.tempC stringValue] stringByAppendingString:@"°"];

}

- (void)configure {
    self.cityLabel.font = [UIFont nunitoBoldWithSize:30.0f];
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    self.temperatureLabel.font = [UIFont nunitoLightWithSize:30.0f];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
}

@end
