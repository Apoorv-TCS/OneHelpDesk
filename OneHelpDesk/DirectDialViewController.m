//
//  DirectDialViewController.m
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 18/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import "DirectDialViewController.h"

@interface DirectDialViewController ()

@end

@implementation DirectDialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Direct Dial";
    _pickerData = @[@"Germany", @"Australia", @"India", @"United States", @"France", @"Sweden"];
    self.phonePicker.delegate = self;
    self.phonePicker.dataSource = self;
    self.phonePicker.hidden = YES;
    self.toolbar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

- (IBAction)selectNumberTapped:(id)sender {
/*    if ([self.phonePicker isHidden]) {
        self.phonePicker.hidden = NO;
        self.toolbar.hidden = NO;
    }
*/
    PhoneTableViewController *phoneListScreen = [[PhoneTableViewController alloc] initWithNibName:@"PhoneTableViewController" bundle:nil];
    phoneListScreen.delegate = self;
    [self.navigationController pushViewController:phoneListScreen animated:YES];
}

- (IBAction)tapCancel:(id)sender {
    if (![self.phonePicker isHidden]) {
        self.phonePicker.hidden = YES;
        self.toolbar.hidden = YES;
    }
}

- (IBAction)tapDone:(id)sender {
    _countryLabel.text = [_pickerData objectAtIndex:[self.phonePicker selectedRowInComponent:0]];
    self.phonePicker.hidden = YES;
    self.toolbar.hidden = YES;
    [_callButton setBackgroundImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_phone_act.png"] forState:UIControlStateNormal];
    [_callButton setEnabled:YES];
    _callLabel.textColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:28/255.0 alpha:1.0];
}

- (void)tableViewController:(PhoneTableViewController *)controller didFinishSelectingNumber:(NSString *)phoneNumber {
    self.countryLabel.text = phoneNumber;
    [_callButton setBackgroundImage:[UIImage imageNamed:@"APP-1_helpdesk-icon_phone_act.png"] forState:UIControlStateNormal];
    [_callButton setEnabled:YES];
    _callLabel.textColor = [UIColor colorWithRed:255/255.0 green:184/255.0 blue:28/255.0 alpha:1.0];
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
