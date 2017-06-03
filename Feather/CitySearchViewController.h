//
//  CitySearchViewController.h
//  Feather
//
//  Created by Renata Guttenová on 21/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol CitySearchViewControllerDelegate <NSObject>
-(void)addCity:(City *)city;
@end

@interface CitySearchViewController : UIViewController
@property (nonatomic, weak) id<CitySearchViewControllerDelegate> delegate;

@end
