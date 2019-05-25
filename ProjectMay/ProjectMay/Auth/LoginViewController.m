//
//  LoginViewController.m
//  Yep
//
//  Created by User on 25.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "LoginViewController.h"
#import "SMSViewController.h"
#import "API.h"
#import "AuthViewController.h"
@interface LoginViewController ()

@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка авторизации!"
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




-(void) dismissKeyboard{
    
    [self.phoneNumber resignFirstResponder];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    
    CGPoint scrollPoint = CGPointMake(0, 130);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    
    [self.scrollView setContentOffset:CGPointZero animated:NO];
    
}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    
    if ([textField isEqual:self.phoneNumber]) {
        textField.text = @"+7";
    } else {
        textField.text = @"";
    }
    // [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.phoneNumber]) {
        [self.view setUserInteractionEnabled:NO];
        
        NSMutableString *stringRange = [self.phoneNumber.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        [self.activityIndicator startAnimating];
        self.activityIndicator.alpha = 1.f;
        //    [self onetimePass:stringRange];
    } 
    return YES;
}





-(void) onetimePass:(NSString *)numTel{
    
    [[API apiManager]onetimePass:numTel
                       onSuccess:^(NSDictionary *responseObject) {
                           
                           [self.activityIndicator stopAnimating];
                           self.activityIndicator.alpha = 0.f;
                           
                           [self.view setUserInteractionEnabled:YES];
                           
                           [self performSegueWithIdentifier:@"smsAuth" sender:self];
                           
                           
                       }  onFailure:^(NSError *error, NSInteger statusCode) {
                           
                           [self.activityIndicator stopAnimating];
                           self.activityIndicator.alpha = 0.f;
                           
                           [self.view setUserInteractionEnabled:YES];
                           
                           
                           NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                           
                           
                           NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                           id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                           
                           NSLog(@"%@",[json objectForKey:@"message"]);
                           
                           
                           self.messageAlert = [json objectForKey:@"message"];
                           [self alerts];
                       }];
}


- (IBAction)actPhoneNumber:(id)sender {
    self.phoneNumber.text = @"+7";

}
- (IBAction)actReg:(id)sender {
    [self performSegueWithIdentifier:@"regs" sender:self];

}

- (IBAction)actNext:(id)sender {
    
    
    
    
    if ([self.phoneNumber.text isEqualToString:@""]) {
        
        self.messageAlert = @"Введите номер телефона";
        [self alerts];
    }else{
        NSMutableString *stringRange = [self.phoneNumber.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self onetimePass:stringRange];
        
    }
    

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    SMSViewController * seguesms;
    AuthViewController * auvc;
    if ([[segue identifier] isEqualToString:@"smsAuth"]){
        
        NSMutableString *stringRange = [self.phoneNumber.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        seguesms = [segue destinationViewController];
        seguesms.phoneNumber = stringRange;
        
    }else if ([[segue identifier] isEqualToString:@"regs"]){
        auvc = [segue destinationViewController];
    }
    
}


@end
