//
//  CitySearchViewController.m
//  Feather
//
//  Created by Renata Guttenová on 21/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "CitySearchViewController.h"
#import "SearchBar.h"
#import "CitySearchTableViewCell.h"
#import <GooglePlaces/GooglePlaces.h>
#import "RequestManager.h"


@interface CitySearchViewController () <UITableViewDelegate, UITableViewDataSource, GMSAutocompleteFetcherDelegate, SearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SearchBar *searchBar;

@property (strong, nonatomic) GMSAutocompleteFetcher *placeFetcher;

@property (strong, nonatomic) NSArray *predictionsArray;

@end

@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Configure

- (void)configure {
    self.searchBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CitySearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CitySearchTableViewCell"];
    
    [self configureCloseButton];
    [self configureAutoComplete];
}

- (void)configureCloseButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,0,30,30);
    UIImage *closeImage = [[UIImage imageNamed: @"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:closeImage forState:UIControlStateNormal];
    button.imageView.tintColor = [UIColor purpleLight];
    [button addTarget:self action:@selector(dismissButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIImage *image = [[UIImage imageNamed:@"splash12x30.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setTintColor:[UIColor purpleLight]];
    self.navigationItem.titleView = imageView;
}

- (void)configureAutoComplete {
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    
    self.placeFetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:nil filter:filter];
    self.placeFetcher.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - TableViewDelegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.predictionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CitySearchTableViewCell *cell = (CitySearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CitySearchTableViewCell"];
    
    [cell configureWithPrediction:self.predictionsArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[RequestManager sharedManager] fetchCityWithPrediction:self.predictionsArray[indexPath.row] withCompletion:^(City *city) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate addCity:city];
        }];
    }];
}

#pragma mark - GMSAutocompleteFetcherDelegate

- (void)didAutocompleteWithPredictions:(NSArray *)predictions {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (GMSAutocompletePrediction *prediction in predictions) {
        [mutableArray addObject:prediction];
    }
    self.predictionsArray = mutableArray;
    [self.tableView reloadData];
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    NSLog(@"DEBUG---- autocomplete failed");
}

#pragma mark - SearchBarDelegate

- (void)textDidChange:(NSString *)text {
    [self.placeFetcher sourceTextHasChanged:text];
}

- (void)dismissButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
