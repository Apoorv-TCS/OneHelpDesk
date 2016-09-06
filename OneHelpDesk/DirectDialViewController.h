//
//  DirectDialViewController.h
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 18/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhoneTableViewController.h"

@interface DirectDialViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, PhoneTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectPhoneButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *phonePicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
