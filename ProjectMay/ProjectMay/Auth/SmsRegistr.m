//
//  SmsRegistr.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "SmsRegistr.h"
#import "API.h"
#import <Security/Security.h>

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
        self.activityIndicator.alpha = 1.f;

        [self confirmOnetimePass:self.phoneNumber onetime_pass:self.smsText.text];

    }
    return YES;
}


- (IBAction)smsAct:(id)sender {
    
}

- (IBAction)nextBtn:(id)sender {
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;

    [self confirmOnetimePass:self.phoneNumber onetime_pass:self.smsText.text];
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
                                  
                                  NSLog(@"%@",responseObject);


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
