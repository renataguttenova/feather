//
//  ForecastTableViewCell.m
//  Feather
//
//  Created by Renata Guttenová on 05/06/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "ForecastTableViewCell.h"
#import "Day.h"

@interface ForecastTableViewCell ()

//@property (strong, nonatomic) NSArray *imageStringArray;

@end

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configure];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithDay:(Day *)day {
    self.label.text = day.date;
    self.weatherIconImageView.image = [UIImage imageNamed:day.iconCode];
}

- (void)configure {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.backgroundColor = [UIColor clearColor];
    self.label.font = [UIFont nunitoLightWithSize:25.0f];
    self.weatherIconImageView.image = [UIImage imageNamed:@"113"];
}

@end
