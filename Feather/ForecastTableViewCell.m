//
//  ForecastTableViewCell.m
//  Feather
//
//  Created by Renata Guttenová on 05/06/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "ForecastTableViewCell.h"

@interface ForecastTableViewCell ()

//@property (strong, nonatomic) NSArray *imageStringArray;

@end

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureWithImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)configureWithImageView {
    self.weatherIconImageView.image = [UIImage imageNamed:@"113"];
}

@end