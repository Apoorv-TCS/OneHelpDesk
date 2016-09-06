//
//  PhoneTableViewController.m
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 22/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import "PhoneTableViewController.h"

@interface PhoneTableViewController ()

@end

@implementation PhoneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.allPhoneNumbers = [[NSMutableArray alloc] init]; //@[@"Germany", @"Australia", @"India", @"United States", @"France", @"Sweden"];
    [self.allPhoneNumbers addObject:@"Germany"];
    [self.allPhoneNumbers addObject:@"Australia"];
    [self.allPhoneNumbers addObject:@"India"];
    [self.allPhoneNumbers addObject:@"United States"];
    [self.allPhoneNumbers addObject:@"France"];
    [self.allPhoneNumbers addObject:@"Sweden"];
    
    self.filteredPhoneNumbers = [[NSMutableArray alloc] init];
    
    self.displayedItems = self.allPhoneNumbers;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    self.searchController.searchBar.delegate = self;
    
    [self.searchController.searchBar sizeToFit];
    
    self.phoneList.tableHeaderView = self.searchController.searchBar;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active && ![self.searchController.searchBar.text isEqualToString:@""]) {
        return [self.filteredPhoneNumbers count];
    }
    return [self.allPhoneNumbers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FruitCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if (self.searchController.active && ![self.searchController.searchBar.text isEqualToString:@""]) {
        cell.textLabel.text = [self.filteredPhoneNumbers objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.allPhoneNumbers objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.searchController.active) {
//        [self.searchController setActive:NO];
//    }
    [self.delegate tableViewController:self didFinishSelectingNumber:[self.displayedItems objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"updateSearchResultsForSearchController");
    
    NSString *searchString = searchController.searchBar.text;
    NSLog(@"searchString=%@", searchString);
    
    // Check if the user cancelled or deleted the search term so we can display the full list instead.
    if (![searchString isEqualToString:@""]) {
        [self.filteredPhoneNumbers removeAllObjects];
        for (NSString *str in self.allPhoneNumbers) {
            if ([searchString isEqualToString:@""] || [str localizedCaseInsensitiveContainsString:searchString] == YES) {
                NSLog(@"str=%@", str);
                [self.filteredPhoneNumbers addObject:str];
            }
        }
        self.displayedItems = self.filteredPhoneNumbers;
    }
    else {
        self.displayedItems = self.allPhoneNumbers;
    }
    [self.phoneList reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self. searchController.view removeFromSuperview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
