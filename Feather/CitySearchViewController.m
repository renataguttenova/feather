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

@property (strong, nonatomic) NSArray *placesArray;

@end

@implementation CitySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CitySearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"CitySearchTableViewCell"];
    
    
    // Set up the autocomplete filter.
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    
    // Create the fetcher.
    self.placeFetcher = [[GMSAutocompleteFetcher alloc] initWithBounds:nil filter:filter];
    self.placeFetcher.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDelegate/Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.placesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CitySearchTableViewCell *cell = (CitySearchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CitySearchTableViewCell"];
    
    [cell configureWithPrediction:self.placesArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[RequestManager sharedManager] fetchPlaceDetailsWithPrediction:self.placesArray[indexPath.row]];
}

#pragma mark - GMSAutocompleteFetcherDelegate
- (void)didAutocompleteWithPredictions:(NSArray *)predictions {
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (GMSAutocompletePrediction *prediction in predictions) {
        [mutableArray addObject:prediction];
    }
    self.placesArray = mutableArray;
    [self.tableView reloadData];
}

- (void)didFailAutocompleteWithError:(NSError *)error {
    NSLog(@"DEBUG---- autocomplete failed");
}

#pragma mark - SearchBarDelegate

- (void)textDidChange:(NSString *)text {
    [self.placeFetcher sourceTextHasChanged:text];
}

- (IBAction)dismissButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
