//
//  MainViewController.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"
#import "CityTableViewCell.h"
#import "City.h"
#import "RequestManager.h"
#import <SVProgressHUD/SVProgressHUD.h>


@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *citiesArray;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed)]; //this s like when we drag the button to connect it - but done rogramatically, so I created a method to set what it does when pressed
    
    [self configureLocationManager];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchWeatherForCurrentLocation) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];  //this is so that the refreshing circle doesnt go over the cell when returning up
}

- (void)addButtonPressed {
    NSLog(@"Add button pressed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)configure {
    [self setTitle:@"Title"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor redColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
}

- (void)configureLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = 100;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"DEBUG___ did change authorization status");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"DEBUG---- did update locations");
    
    self.currentLocation = [locations firstObject];
    
    [self fetchWeatherForCurrentLocation];
}

- (void)fetchWeatherForCurrentLocation {
    
    if (![self.refreshControl isRefreshing]) {
        [SVProgressHUD show];
    }

    [[RequestManager sharedManager] requestCurrentWeatherWithCoordinate:self.currentLocation.coordinate withCompletion:^(City *city) {
        
        [SVProgressHUD dismiss];
        [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.5f];
        
        if (city) {
            self.citiesArray = @[city];
            [self.tableView reloadData];
        }
        
    }];
}

- (void)finishRefresh {
    [self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.citiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
    
    City *city = self.citiesArray[indexPath.row];
    [cell configureWithCity:city];
    
    return cell;
}




@end
