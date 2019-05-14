//
//  FinalRegistration.h
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalRegistration : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSMutableArray * arrayCity;
@property (strong, nonatomic) NSMutableArray * arrayFloor;
@property (weak, nonatomic)  UIDatePicker * pickerDateView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (IBAction)regBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *nt;
@property (weak, nonatomic) IBOutlet UIButton *readyOutlet;
- (IBAction)readyAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *sityLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *menLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameOtl;
- (IBAction)actName:(id)sender;

@end
