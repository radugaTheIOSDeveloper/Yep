//
//  AuthViewController.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "AuthViewController.h"
#import "API.h"
#import "SmsRegistr.h"
#import "LoginViewController.h"
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
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.backBarButtonItem = nil;
     self.navigationItem.leftBarButtonItem = nil;
}
#pragma mark API



-(void) onetimePass:(NSString *)numTel{

    [[API apiManager]onetimePass:numTel
                              onSuccess:^(NSDictionary *responseObject) {

                                  [self.activityIndicator stopAnimating];
                                  self.activityIndicator.alpha = 0.f;

                                  [self.view setUserInteractionEnabled:YES];

                                  [self performSegueWithIdentifier:@"sms" sender:self];


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
        
        NSMutableString *stringRange = [self.phoneTextOutlet.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        [self.activityIndicator startAnimating];
        self.activityIndicator.alpha = 1.f;
        [self onetimePass:stringRange];
        
    
    }
    return YES;
}




- (IBAction)au:(id)sender {
    [self performSegueWithIdentifier:@"authd" sender:self];

}

- (IBAction)nextBtn:(id)sender {
    
    if ([self.phoneTextOutlet.text isEqualToString:@""]) {
        
        self.messageAlert = @"Введите номер телефона";
        [self alerts];
    }else{
        NSMutableString *stringRange = [self.phoneTextOutlet.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        self.activityIndicator.alpha = 1.f;
        [self.activityIndicator startAnimating];
        [self onetimePass:stringRange];
        
    }
    


}

- (IBAction)phoneAct:(id)sender {
    self.phoneTextOutlet.text = @"+7";

}

- (IBAction)nameAct:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    

    
    SmsRegistr * seguesms;
    LoginViewController * lvc;
    if ([[segue identifier] isEqualToString:@"sms"]){
        
        NSMutableString *stringRange = [self.phoneTextOutlet.text mutableCopy];
        NSRange range = NSMakeRange(0, 1);
        [stringRange deleteCharactersInRange:range];
        seguesms = [segue destinationViewController];
        seguesms.phoneNumber = stringRange;

    }else if ([[segue identifier] isEqualToString:@"authd"]){
        lvc = [segue destinationViewController];

    }
    
}
@end
