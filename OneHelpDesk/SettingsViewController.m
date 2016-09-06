//
//  SettingsViewController.m
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 19/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property BOOL callLanguageSelected;
@property BOOL appLanguageSelected;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Settings";
    self.pickerView.hidden = YES;
    self.toolbar.hidden = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.appLanguages = @[@"English", @"German", @"French", @"Spanish", @"Chinese", @"Japanese", @"Russian", @"Finnish"];
    self.callLanguages = @[@"English", @"German", @"French", @"Spanish", @"Chinese", @"Japanese"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"callLanguage"]) {
        [self.callLanguageBtn setTitle:[defaults objectForKey:@"callLanguage"] forState:UIControlStateNormal];
    }
    if ([defaults objectForKey:@"appLanguage"]) {
        [self.appLanguageBtn setTitle:[defaults objectForKey:@"appLanguage"] forState:UIControlStateNormal];
    }
}

- (IBAction)tapCallLanguage:(id)sender {
    if ([self.pickerView isHidden]) {
        self.pickerView.hidden = NO;
        self.toolbar.hidden = NO;
        self.callLanguageSelected = YES;
        self.appLanguageSelected = NO;
        [self.pickerView reloadAllComponents];
    }
}

- (IBAction)tapAppLanguage:(id)sender {
    if ([self.pickerView isHidden]) {
        self.pickerView.hidden = NO;
        self.toolbar.hidden = NO;
        self.callLanguageSelected = NO;
        self.appLanguageSelected = YES;
        [self.pickerView reloadAllComponents];
    }
}

- (IBAction)tapCancel:(id)sender {
    if (![self.pickerView isHidden]) {
        self.pickerView.hidden = YES;
        self.toolbar.hidden = YES;
    }
}

- (IBAction)tapDone:(id)sender {
    if (self.callLanguageSelected) {
        [self.callLanguageBtn setTitle:[self.callLanguages objectAtIndex:[self.pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    }
    else if (self.appLanguageSelected) {
        [self.appLanguageBtn setTitle:[self.appLanguages objectAtIndex:[self.pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    }
    self.pickerView.hidden = YES;
    self.toolbar.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.callLanguageSelected)
        return self.callLanguages.count;
    else if (self.appLanguageSelected)
        return self.appLanguages.count;
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.callLanguageSelected)
        return self.callLanguages[row];
    else if (self.appLanguageSelected)
        return self.appLanguages[row];
    return @"Bug";
}

- (void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.callLanguageBtn.titleLabel.text forKey:@"callLanguage"];
    [defaults setObject:self.appLanguageBtn.titleLabel.text forKey:@"appLanguage"];
    
    [defaults synchronize];
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
