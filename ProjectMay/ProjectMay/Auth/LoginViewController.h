//
//  LoginViewController.h
//  Yep
//
//  Created by User on 25.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
- (IBAction)actPhoneNumber:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
- (IBAction)actReg:(id)sender;

- (IBAction)actNext:(id)sender;
@end
