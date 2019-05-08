//
//  SmsRegistr.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "SmsRegistr.h"

@interface SmsRegistr ()

@end

@implementation SmsRegistr

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    
    [self.smsText resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGPoint scrollPoint = CGPointMake(0, 130);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.smsText]) {
        
        [self performSegueWithIdentifier:@"nextReg" sender:self];

    }
    return YES;
}


- (IBAction)smsAct:(id)sender {
    
}

- (IBAction)nextBtn:(id)sender {
    [self performSegueWithIdentifier:@"nextReg" sender:self];

}
@end
