//
//  SMSViewController.m
//  Yep
//
//  Created by User on 25.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "SMSViewController.h"
#import "API.h"
@interface SMSViewController ()
@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation SMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) dismissKeyboard{
    
    [self.sms resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.sms]) {
        
        [self.activityIndicator startAnimating];
        self.activityIndicator.alpha = 1.f;
        
        [self confirmOnetimePass:self.phoneNumber onetime_pass:self.sms.text];
        
    }
    return YES;
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



- (IBAction)actSms:(id)sender {
}
- (IBAction)actNext:(id)sender {
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    
    [self confirmOnetimePass:self.phoneNumber onetime_pass:self.sms.text];
}


-(void) confirmOnetimePass:(NSString *)numTel
              onetime_pass:(NSString *)onetime_pass{
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.alpha = 0.f;
    
    [[API apiManager]confirmOnetimePass:numTel
                           onetime_pass:onetime_pass
     
     
                              onSuccess:^(NSDictionary *responseObject) {
                                  [self.activityIndicator stopAnimating];
                                  self.activityIndicator.alpha = 0.f;
                                  
                                  
                                  NSLog(@"responce object = %@" , responseObject);
                                  
                                  [[API apiManager]setToken:[NSString stringWithFormat:@"Token %@",[responseObject objectForKey:@"token"]]];
                                  
                                  [[API apiManager]setExisting_user:[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"existing_user"]]];
                                  
                                  NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                                  [userDefaults setObject:@"true" forKey:@"token"];
                                  
                                  
                                  if ([[responseObject objectForKey:@"existing_user"] isEqualToString:@"Y"]) {
                                      NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                                      NSMutableArray * arruser = [NSMutableArray array];
                                      arruser = [responseObject objectForKey:@"user_info"];
                                      NSDictionary * hot = [arruser objectAtIndex:0];
                                      
                                      [userDefaults setObject:[hot objectForKey:@"city"] forKey:@"city"];
                                      [userDefaults setObject:[hot objectForKey:@"date_of_birth"] forKey:@"birth_date"];
                                      [userDefaults setObject:[hot objectForKey:@"name"] forKey:@"name"];
                                      [userDefaults setObject:[hot objectForKey:@"sex"] forKey:@"sex"];
                                    
                                      
                                      UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                           UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navController"];
                                                           pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                                           [self presentViewController:pvc animated:YES completion:nil];
                                      
                                  }else if ([[responseObject objectForKey:@"existing_user"] isEqualToString:@"N"]) {
                                      
                                         UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                                            UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"finalRegistration"];
                                                                                            pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                                                                            [self presentViewController:pvc animated:YES completion:nil];
                                      
                                  }
                                  
                                  
                              } onFailure:^(NSError *error, NSInteger statusCode) {
                                  
                                  [self.activityIndicator stopAnimating];
                                  self.activityIndicator.alpha = 0.f;
                                  
                                  NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                                  
                                  
                                  NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                                  id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                  
                                  NSLog(@"%@",[json objectForKey:@"message"]);
                                  
                                  
                                  self.messageAlert = [json objectForKey:@"message"];
                                  [self alerts];
                              }];
}

@end
