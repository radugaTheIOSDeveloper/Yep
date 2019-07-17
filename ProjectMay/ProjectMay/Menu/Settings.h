//
//  Settings.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

//property outlet
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sity;

@property (weak, nonatomic) IBOutlet UITextField *nameTextOtl;

@property (weak, nonatomic) IBOutlet UILabel *dateSettings;
@property (weak, nonatomic) IBOutlet UILabel *citySettings;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerSettings;
@property (weak, nonatomic) IBOutlet UIButton *goodBtnOtl;

- (IBAction)goodSettings:(id)sender;
- (IBAction)nameActText:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

- (IBAction)actBtnSettings:(id)sender;

@property (strong, nonatomic) NSMutableArray * arrayMaleSettings;
@property (strong, nonatomic) NSMutableArray * arrayIDCitySettings;
@property (strong, nonatomic) NSMutableArray * arrayCitySettings;


@property (weak, nonatomic) IBOutlet UIPickerView *cityPickerSettings;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
