//
//  SmsRegistr.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "SmsRegistr.h"
#import "API.h"

@interface SmsRegistr ()
@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation SmsRegistr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    
    NSLog(@"phone number = %@", self.phoneNumber);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    
    [self.smsText resignFirstResponder];
}

//-(void) textFieldDidBeginEditing:(UITextField *)textField{
//    
//    CGPoint scrollPoint = CGPointMake(0, 130);
//    [self.scrollView setContentOffset:scrollPoint animated:NO];
//    
//}
//
//-(void)textFieldDidEndEditing:(UITextField*)textField{
//    
//    [self.scrollView setContentOffset:CGPointZero animated:NO];
//    
//}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.smsText]) {
        
        [self.activityIndicator startAnimating];
        [self confirmOnetimePass:self.phoneNumber onetime_pass:self.smsText.text];

    }
    return YES;
}


- (IBAction)smsAct:(id)sender {
    
}

- (IBAction)nextBtn:(id)sender {
    [self.activityIndicator startAnimating];
    [self confirmOnetimePass:self.phoneNumber onetime_pass:self.smsText.text];
}


-(void) confirmOnetimePass:(NSString *)numTel
              onetime_pass:(NSString *)onetime_pass{
    
    [self.activityIndicator stopAnimating];

    [[API apiManager]confirmOnetimePass:numTel
                            onetime_pass:onetime_pass
     

                              onSuccess:^(NSDictionary *responseObject) {
                                  [self performSegueWithIdentifier:@"nextReg" sender:self];

        } onFailure:^(NSError *error, NSInteger statusCode) {

            
            
            NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
            
            
            NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSLog(@"%@",[json objectForKey:@"message"]);
            
            
            self.messageAlert = [json objectForKey:@"message"];
            [self alerts];
        }];
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка регистрации!"
                                 message:self.messageAlert
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
