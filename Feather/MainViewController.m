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
#import "CitySearchViewController.h"
#import "ForecastViewController.h"


@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, CitySearchViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *citiesArray;
@property (strong, nonatomic) City *currentCity;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.citiesArray = [self retrieveCitiesFromNSUserDefaults];
    [self configure];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed)]; //this is like when we drag the button to connect it - but done programatically, so I created a method to set what it does when pressed
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blueLight];
    
    [self configureLocationManager];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(updateCitiesWithCurrentWeather) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];  //this is so that the refreshing circle doesnt go over the cell when returning up
    
    [self updateCitiesWithCurrentWeather];
}

- (void)addButtonPressed {
    CitySearchViewController *citySearchViewController = [[CitySearchViewController alloc] init];
    citySearchViewController.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:citySearchViewController];
    
    navigationController.navigationBar.translucent = NO;
    [self presentViewController:navigationController animated:YES completion:nil];
//    [self presentViewController:citySearchViewController animated:YES completion:nil];
}

- (void)finishRefresh {
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)configure {
    [self setTitle:@"Title"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blueLight]}];
    
    UIImage *image = [[UIImage imageNamed:@"splash12x30.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setTintColor:[UIColor blueLight]];
    self.navigationItem.titleView = imageView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor = [UIColor blueLight];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
}

- (void)configureLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = 100;  //minimum distance in meters I have to move so that it updates the location
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)updateCitiesWithCurrentWeather {
    
    if (![self.refreshControl isRefreshing]) {
        [SVProgressHUD show];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    
    if (self.currentCity) {
        [mutableArray addObject:self.currentCity];
    }
    
    if (self.citiesArray.count) {
        [mutableArray addObjectsFromArray:self.citiesArray];
    }
    
    dispatch_group_t group = dispatch_group_create();
    
    for (City *city in mutableArray) {
        dispatch_group_enter(group);
        [[RequestManager sharedManager] updateCityWithCurrentWeather:city withCompletion:^{  //sharedManager - we create a singleton because we want all these requests to be done by one RequestManager - to assure the requests happen one after another and not all at once performed by many requestManagers. With Completion means that the following code will NOT run until the previous one is fnished
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all jobs finished");
        [SVProgressHUD dismiss];
        [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.5f];
        [self.tableView reloadData];
    });
    
    
    //    [[RequestManager sharedManager] requestCurrentWeatherWithCoordinate:self.currentLocation.coordinate withCompletion:^(City *city) {
    //
    //        [SVProgressHUD dismiss];
    //        [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.5f];
    //
    //        if (city) {
    //            self.citiesArray = @[city];
    //            [self.tableView reloadData];
    //        }
    //        
    //    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"DEBUG___ did change authorization status");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"DEBUG---- did update locations");
    
    self.currentLocation = [locations firstObject];
    
    [SVProgressHUD show];
    
    [[RequestManager sharedManager] fetchCityWithCurrentWeatherWithCoordinate:self.currentLocation.coordinate withCompletion:^(City *city) {
        self.currentCity = city;
        [self updateCitiesWithCurrentWeather];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentCity) {
        return self.citiesArray.count + 1;
    } else {
        return self.citiesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
    
    if (self.currentCity) {
        if (indexPath.row == 0) {
            [cell configureWithCity:self.currentCity andBackgroundColor:[UIColor blueDark]];
        } else {
            [cell configureWithCity:self.citiesArray[indexPath.row - 1] andBackgroundColor:self.view.backgroundColor];
        }
    } else {
        [cell configureWithCity:self.citiesArray[indexPath.row] andBackgroundColor:self.view.backgroundColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    City *selectedCity;
    
    if (self.currentCity) {
        if (indexPath.row == 0) {
            selectedCity = self.currentCity;
        } else {
            selectedCity = self.citiesArray[indexPath.row - 1];
        }
    } else {
        selectedCity = self.citiesArray[indexPath.row];
    }
    
    
    [[RequestManager sharedManager] fetchDaysWithCoordinate:selectedCity.coordinate withCompletion:^(NSArray *days) {
        ForecastViewController *viewController = [[ForecastViewController alloc] initWithNibName:@"ForecastViewController" bundle:nil];
        viewController.city = selectedCity;
        viewController.days = days;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)addCity:(City *)city {
    
    BOOL duplicate = NO;   //making sure that user will not be able to add the same city twice
    
    for (City *existingCity in self.citiesArray) {
        if ([city.googlePlaceID isEqualToString:existingCity.googlePlaceID]) {
            duplicate = YES;
        }
    }
    
    if (!duplicate) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.citiesArray];
        [mutableArray addObject:city];
        self.citiesArray = mutableArray;
        [self updateCitiesWithCurrentWeather];
        
        [self saveCityToNSUserDefaults:city];
    }
}

- (void)saveCityToNSUserDefaults:(City *)city {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if (![userDefaults objectForKey:@"cities"]) {
        NSArray *cities = [NSArray array];
        [userDefaults setObject:cities forKey:@"cities"];
        [userDefaults synchronize];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[userDefaults objectForKey:@"cities"]];
    
    NSString *latitude = [NSString stringWithFormat:@"%.5f", city.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%.5f", city.coordinate.longitude];
    
    NSDictionary *dict = @{@"name":city.locationName, @"placeID":city.googlePlaceID, @"latitude":latitude, @"longitude":longitude};
    [mutableArray addObject:dict];
    
    NSArray *array = [NSArray arrayWithArray:mutableArray];
    [userDefaults setObject:array forKey:@"cities"];
    [userDefaults synchronize];
}

- (NSArray *)retrieveCitiesFromNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedCities = [userDefaults objectForKey:@"cities"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dict in savedCities) {
        
        City *city = [[City alloc] init];
        city.locationName = dict[@"name"];
        city.googlePlaceID = dict[@"placeID"];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([dict[@"latitude"] doubleValue], [dict[@"longitude"] doubleValue]);
        city.coordinate = coordinate;
        
        [mutableArray addObject:city];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

@end
