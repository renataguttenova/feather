//
//  CitySearchTableViewCell.h
//  Feather
//
//  Created by Renata Guttenová on 27/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlaces/GooglePlaces.h>

@interface CitySearchTableViewCell : UITableViewCell

- (void)configureWithPrediction:(GMSAutocompletePrediction *)prediction;

@end
