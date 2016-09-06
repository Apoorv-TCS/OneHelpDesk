//
//  HomeScreenViewController.h
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 17/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PhoneTableViewController.h"

@interface HomeScreenViewController : UIViewController<CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, PhoneTableViewControllerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UIImageView *warningImage;
@property (weak, nonatomic) IBOutlet UITextView *warningMsg;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectPhoneButton;
@property (weak, nonatomic) IBOutlet UIPickerView *numberPicker;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSArray *pickerData;

@end
