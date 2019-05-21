//
//  NextDetail.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextDetail : UIViewController
- (IBAction)yourWish:(id)sender;
- (IBAction)nextBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *otlYourWih;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@property (strong, nonatomic) NSString * idCat;
@property (weak, nonatomic) IBOutlet UILabel *dateOrder;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) NSString *messageAlert;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnNextD;
@property (weak, nonatomic) IBOutlet UIButton *good;
- (IBAction)goodAct:(id)sender;

@end
