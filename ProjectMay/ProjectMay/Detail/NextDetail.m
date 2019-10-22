//
//  NextDetail.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "NextDetail.h"
#import "API.h"

@interface NextDetail ()

@end

@implementation NextDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.hidesBackButton = YES;

    self.datePicker.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",_idCat);

    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];
    
    self.datePicker.alpha = 0.f;
    

    self.dateOrder.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(didTapLabelWithGesturesityLabel:)];
    [self.dateOrder addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.good.alpha = 0.f;
    [self backButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

//-(void) backButton2 {
//
//    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BtnReady"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped2:)];
//    self.navigationItem.rightBarButtonItem = btn;
//
//
//
//}
//
//- (void)backTapped2:(id)sender {
//
//    self.navigationItem.rightBarButtonItem = NULL;
//}


- (void)backTapped:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navControlls"];
        pvc.modalPresentationStyle = UIModalPresentationFullScreen;
    
                                               [self presentViewController:pvc animated:YES completion:nil];
    
}

#pragma mark API


-(void) bids:(NSString *)category
        wish:(NSString *)wish
   wish_date:(NSString *)wish_date{
    
    
    [[API apiManager] bids:category wish:wish wish_date:wish_date
     
                 onSuccess:^(NSDictionary *responseObject) {
                     
                     [self.activityIndicator stopAnimating];
                     self.activityIndicator.alpha = 0.f;
                     [self.view setUserInteractionEnabled:YES];
                     
                     NSLog(@"%@",responseObject);
                     [self performSegueWithIdentifier:@"good" sender:self];

                     
                 } onFailure:^(NSError *error, NSInteger statusCode) {
                     
                     [self.activityIndicator stopAnimating];
                     self.activityIndicator.alpha = 0.f;
                     [self.view setUserInteractionEnabled:YES];
                     NSLog(@"%@",error);
                     NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                     
                     
                     NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                     id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     
                     NSLog(@"erro: \n%@",json);
                     self.messageAlert = [json objectForKey:@"message"];
                     [self alerts];
                 }];
    
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка!"
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
- (IBAction)yourWish:(id)sender {
    
    [UIView animateWithDuration:1.0 animations:^{
        self.good.alpha = 0.f;
        self.datePicker.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (IBAction)nextBtn:(id)sender {
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    
    [self bids:_idCat wish:self.otlYourWih.text wish_date:self.dateOrder.text];

}


#pragma mark label

- (void)didTapLabelWithGesturesityLabel:(UITapGestureRecognizer *)tapGesture {
    
    self.btnNextD.alpha = 0.f;
    self.good.alpha = 1.f;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.datePicker.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

-(void) dismissKeyboard{
    
    [self.otlYourWih resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([textField isEqual:self.otlYourWih]) {
        
        [self dismissKeyboard];
        
        
    }
    return YES;
}

- (IBAction)goodAct:(id)sender {
    
    


    [UIView animateWithDuration:1.0 animations:^{
        self.datePicker.alpha = 0.0f;
        self.btnNextD.alpha = 1.f;
        self.good.alpha = 0.f;
    } completion:^(BOOL finished) {
        
     
        
    }];
    
    NSDate * choise = [self.datePicker date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    NSString *myDayString = [df stringFromDate:choise];
    self.dateOrder.text = myDayString;

    
}
@end
