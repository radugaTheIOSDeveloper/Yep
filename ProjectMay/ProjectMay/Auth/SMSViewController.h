//
//  SMSViewController.h
//  Yep
//
//  Created by User on 25.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *sms;
- (IBAction)actSms:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;
- (IBAction)actNext:(id)sender;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString * phoneNumber;

@end
