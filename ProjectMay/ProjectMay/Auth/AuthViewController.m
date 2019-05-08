//
//  AuthViewController.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "AuthViewController.h"

@interface AuthViewController ()

@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor blueColor];
    [self.view setUserInteractionEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark TextField and Keyboard

-(void) dismissKeyboard{
    
    [self.phoneTextOutlet resignFirstResponder];
    [self.nameTextOutlet resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGPoint scrollPoint = CGPointMake(0, 130);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    
    if ([textField isEqual:self.phoneTextOutlet]) {
        textField.text = @"+7";
    } else {
        textField.text = @"";
    }
    // [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.phoneTextOutlet]) {
        [self.nameTextOutlet becomeFirstResponder];

    } else {
        [self.view setUserInteractionEnabled:NO];
        [self performSegueWithIdentifier:@"sms" sender:self];

     //   self.activityIndicator.alpha = 1.f;
     //   [self.activityIndicator startAnimating];
        
    
    }
    return YES;
}




- (IBAction)nextBtn:(id)sender {
    
    [self performSegueWithIdentifier:@"sms" sender:self];

}

- (IBAction)phoneAct:(id)sender {
    self.phoneTextOutlet.text = @"+7";

}

- (IBAction)nameAct:(id)sender {
}


@end
