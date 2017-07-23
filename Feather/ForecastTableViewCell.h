//
//  ForecastTableViewCell.h
//  Feather
//
//  Created by Renata Guttenová on 05/06/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@interface ForecastTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImageView;

- (void)configureWithDay:(Day *)day;



@end
