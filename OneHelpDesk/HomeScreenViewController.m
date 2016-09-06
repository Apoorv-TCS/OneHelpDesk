//
//  HomeScreenViewController.m
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 17/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "DirectDialViewController.h"
#import "SettingsViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"ONE HelpDesk";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:28/255.0 alpha:1.0];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(tapSettings:)];
    [self getLocation];
    _pickerData = @[@"Germany", @"Australia", @"India", @"United States", @"France", @"Sweden"];
    self.numberPicker.delegate = self;
    self.numberPicker.dataSource = self;
    self.numberPicker.hidden = YES;
    self.toolbar.hidden = YES;
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    [self.mm_drawerController setMaximumRightDrawerWidth:screenSize.size.width - 80 animated:YES completion:nil];
}

- (void)tapSettings:(id)sender {
/*
    SettingsViewController *settingsScreen = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsScreen animated:YES];
*/
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)getLocation {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    _currentLocation = [locations objectAtIndex:0];
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusDenied) {
        _warningLabel.hidden = NO;
        _warningMsg.hidden = NO;
        _warningImage.hidden = NO;
        _countryLabel.text = @"Unavailable";
        [_selectPhoneButton setTitle:@"Please Select a Number" forState:UIControlStateNormal];
        [_selectPhoneButton setEnabled:YES];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_phone_dis.png"] forState:UIControlStateNormal];
        [_callButton setEnabled:NO];
        _callLabel.textColor = [UIColor lightGrayColor];
    }
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        _warningLabel.hidden = YES;
        _warningMsg.hidden = YES;
        _warningImage.hidden = YES;
        _countryLabel.text = @"Germany";
        [_selectPhoneButton setTitle:@"+49 0551 308-3030" forState:UIControlStateNormal];
        [_selectPhoneButton setEnabled:NO];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_phone_act.png"] forState:UIControlStateNormal];
        [_callButton setEnabled:YES];
        _callLabel.textColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:28/255.0 alpha:1.0];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

- (IBAction)selectNumberTapped:(id)sender {
/*    if ([self.numberPicker isHidden]) {
        self.numberPicker.hidden = NO;
        self.toolbar.hidden = NO;
    }
*/ 
    PhoneTableViewController *phoneListScreen = [[PhoneTableViewController alloc] initWithNibName:@"PhoneTableViewController" bundle:nil];
    phoneListScreen.delegate = self;
    [self jsonData];
    [self.navigationController pushViewController:phoneListScreen animated:YES];
}

- (IBAction)tapCancel:(id)sender {
    if (![self.numberPicker isHidden]) {
        self.numberPicker.hidden = YES;
        self.toolbar.hidden = YES;
    }
}

- (IBAction)tapDone:(id)sender {
    _countryLabel.text = [_pickerData objectAtIndex:[self.numberPicker selectedRowInComponent:0]];
    self.numberPicker.hidden = YES;
    self.toolbar.hidden = YES;
    [_callButton setBackgroundImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_phone_act.png"] forState:UIControlStateNormal];
    [_callButton setEnabled:YES];
    _callLabel.textColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:28/255.0 alpha:1.0];
}

- (IBAction)directDialTapped:(id)sender {
    DirectDialViewController *directDialScreen = [[DirectDialViewController alloc] initWithNibName:@"DirectDialViewController" bundle:nil];
    [self.navigationController pushViewController:directDialScreen animated:YES];
}

- (void)tableViewController:(PhoneTableViewController *)controller didFinishSelectingNumber:(NSString *)phoneNumber {
    self.countryLabel.text = phoneNumber;
}

- (NSDictionary *)jsonData {
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"HelpDeskNumber_SampleJSON" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"Error: was not able to load messages.");
        return nil;
    }
    return json;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
