//
//  AuthViewController.h
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelReg;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextOutlet;

@property (weak, nonatomic) IBOutlet UITextField *nameTextOutlet;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


- (IBAction)nextBtn:(id)sender;
- (IBAction)phoneAct:(id)sender;

- (IBAction)nameAct:(id)sender;

@end
