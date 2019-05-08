//
//  SmsRegistr.h
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmsRegistr : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *smsText;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

- (IBAction)smsAct:(id)sender;

- (IBAction)nextBtn:(id)sender;
@end
