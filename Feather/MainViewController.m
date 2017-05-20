//
//  MainViewController.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "MainViewController.h"
#import "CityTableViewCell.h"


@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *citiesArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
   // [self configureRightBarButtonItem];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed)]; //this s like when we drag the button to connect it - but done rogramatically, so I created a method to set what it does when pressed
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
    
    self.citiesArray = @[@"Barcelona", @"Helsinki", @"Prague", @"Copenhagen",
                        @"Berlin", @"Sofia"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.citiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityTableViewCell *cell = (CityTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CityTableViewCell"];
    
    NSString *cityString = self.citiesArray[indexPath.row];
    cell.cityLabel.text = cityString;
    
    return cell;
}

//- (void)configureRightBarButtonItem {
//    UIBarButtonItem *buttonAdd = [[[UIBarButtonItem alloc] initWithTitle:@"+"
//                                                                   style:UIBarButtonItemStyleBordered
//                                                                  target:self
//                                                                  //action:@selector(dismiss)]autorelease];
//    
//    self.navigationItem.rightBarButtonItem = buttonAdd;
//    
//    //[btnCancel release]; no need to explicitly release the item
//    
//}


@end
