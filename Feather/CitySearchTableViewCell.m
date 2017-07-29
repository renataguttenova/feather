//
//  CitySearchTableViewCell.m
//  Feather
//
//  Created by Renata Guttenová on 27/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "CitySearchTableViewCell.h"

@interface CitySearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation CitySearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configure];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configure {
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.font = [UIFont nunitoRegularWithSize:22.0f];
    self.label.textColor = [UIColor grayDarkest];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)configureWithPrediction:(GMSAutocompletePrediction *)prediction {
    self.label.text = [prediction.attributedFullText string];
}

@end
