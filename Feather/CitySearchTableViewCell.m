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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithPrediction:(GMSAutocompletePrediction *)prediction {
    self.label.text = [prediction.attributedFullText string];
    self.label.textColor = [UIColor grayDarkest];
    self.contentView.backgroundColor = [UIColor redLight];
    self.label.backgroundColor = [UIColor redDark];
}

@end
