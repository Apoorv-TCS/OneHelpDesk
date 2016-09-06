//
//  SettingsViewController.h
//  OneHelpDesk
//
//  Created by Aniruddha Kelkar on 19/08/16.
//  Copyright © 2016 TCSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIButton *callLanguageBtn;
@property (weak, nonatomic) IBOutlet UIButton *appLanguageBtn;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (strong, nonatomic) NSArray *appLanguages;
@property (strong, nonatomic) NSArray *callLanguages;

@end
