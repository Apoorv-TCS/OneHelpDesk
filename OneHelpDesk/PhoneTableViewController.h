//
//  PhoneTableViewController.h
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 22/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhoneTableViewController;

@protocol PhoneTableViewControllerDelegate <NSObject>

- (void)tableViewController:(PhoneTableViewController *)controller didFinishSelectingNumber:(NSString *)phoneNumber;

@end

@interface PhoneTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *phoneList;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *allPhoneNumbers;
@property (strong, nonatomic) NSMutableArray *filteredPhoneNumbers;
@property (strong, nonatomic) NSArray *displayedItems;
@property (weak, nonatomic) id <PhoneTableViewControllerDelegate> delegate;

@end
