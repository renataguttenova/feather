//
//  ForecastViewController.m
//  Feather
//
//  Created by Renata Guttenová on 05/06/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastTableViewCell.h"
#import "CityTableViewCell.h"
#import "RequestManager.h"

@interface ForecastViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation ForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ForecastTableViewCell" bundle:nil] forCellReuseIdentifier:@"ForecastTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.days.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
        [cell configureWithCity:self.city];
        return cell;
        
    } else {
        
        ForecastTableViewCell *cell = (ForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ForecastTableViewCell"];
        
        [cell configureWithDay:self.days[indexPath.row - 1]];
        
        return cell;

    }
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
//
//    if (self.currentCity) {
//        if (indexPath.row == 0) {
//            [cell configureWithCity:self.currentCity];
//        } else {
//            [cell configureWithCity:self.citiesArray[indexPath.row - 1]];
//        }
//    } else {
//        [cell configureWithCity:self.citiesArray[indexPath.row]];
//    }
//    return cell;
//}

@end
