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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(updateCitiesWithCurrentTemperature) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)updateCitiesWithCurrentTemperature {
    
    if (![self.refreshControl isRefreshing]) {
        [SVProgressHUD show];
    }
  
      dispatch_group_t group = dispatch_group_create();
   
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"all jobs finished");
        [SVProgressHUD dismiss];
        [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.5f];
        [self.tableView reloadData];
    });
}

- (void)finishRefresh {
    [self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
        
        return cell;
    } else {
        ForecastTableViewCell *cell = (ForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ForecastTableViewCell"];
        
        return cell;
    }
}
    



@end
