//
//  Settings.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "Settings.h"
#import "API.h"
@interface Settings ()

@end
NSInteger statusSettings;
NSString * messageAlerts;
NSString * strSettings;
NSString * idCitySettings;

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    
    
    [self backButton];
    
    self.arrayCitySettings = [NSMutableArray array];
    self.arrayIDCitySettings = [NSMutableArray array];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
    
    self.datePickerSettings.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.nameTextOtl.text = [userDefaults objectForKey:@"name"];
    self.citySettings.text = [userDefaults objectForKey:@"city"];
    self.dateSettings.text = [userDefaults objectForKey:@"birth_date"];
    
    
    self.nameTextOtl.textColor = [UIColor lightGrayColor];
    self.citySettings.textColor = [UIColor lightGrayColor];
    self.dateSettings.textColor = [UIColor lightGrayColor];

    
    NSLog(@"%@",[userDefaults objectForKey:@"birth_date"]);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.cityPickerSettings.delegate = self;
    self.cityPickerSettings.dataSource = self;
    
    self.dateSettings.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(didTapLabelWithGesturesityLabel:)];
    [self.dateSettings addGestureRecognizer:tapGesture];
    
    self.citySettings.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(didTapLabelWithGesturedateLabel:)];
    [self.citySettings addGestureRecognizer:tapGesture2];
    
    self.datePickerSettings.alpha = 0.f;
    self.cityPickerSettings.alpha = 0.f;
    self.goodBtnOtl.alpha = 0.f;
    
//    statusSettings = 1;
//
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self getCiys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
- (void)backTapped:(id)sender {
    [self performSegueWithIdentifier:@"menuSettings" sender:self];
}

-(void) getCiys {
    
    [[API apiManager]getCitys:^(NSDictionary *responceObject) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        NSMutableArray * city = [responceObject valueForKey:@"name"];
        NSMutableArray * iis = [responceObject valueForKey:@"id"];
        self.arrayCitySettings = city;
        self.arrayIDCitySettings = iis;
        NSLog(@"%@",city);
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        NSLog(@"%@",error);
    }];
    
}


-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:messageAlerts
                                 message:NULL
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

    [self.nameTextOtl resignFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if ([textField isEqual:self.nameTextOtl]) {

        [self dismissKeyboard];

    }
    return YES;
}

- (void)didTapLabelWithGesturesityLabel:(UITapGestureRecognizer *)tapGesture {
    [self dismissKeyboard];
    
    self.dateSettings.textColor = [UIColor darkGrayColor];

    statusSettings = 1;
    self.btnSettings.alpha = 0.f;
    self.goodBtnOtl.alpha = 1.f;
    
    
    self.datePickerSettings.alpha = 0.0f;
    self.cityPickerSettings.alpha = 0.0f;

    [UIView animateWithDuration:1.0 animations:^{
        self.datePickerSettings.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        
    }];
    
}


- (void)didTapLabelWithGesturedateLabel:(UITapGestureRecognizer *)tapGesture {
    [self dismissKeyboard];

    statusSettings = 2;
    
    self.citySettings.textColor = [UIColor darkGrayColor];

    
    self.cityPickerSettings.alpha = 1.f;
    self.btnSettings.alpha = 0.f;
    self.goodBtnOtl.alpha = 1.f;
    
    [self.cityPickerSettings reloadAllComponents];
    self.cityPickerSettings.alpha = 0.0f;
    self.datePickerSettings.alpha = 0.0f;

    [UIView animateWithDuration:1.0 animations:^{
        self.cityPickerSettings.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        
    }];
    
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"text changed: %@", textField.text);
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    return self.arrayCitySettings.count;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.arrayCitySettings objectAtIndex:row];

}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    idCitySettings = [self.arrayIDCitySettings objectAtIndex:row];
    strSettings = [self.arrayCitySettings objectAtIndex:row];

    NSLog(@"докоснулись");
}



- (IBAction)goodSettings:(id)sender {
    
    if (statusSettings == 1) {
        self.goodBtnOtl.alpha = 0.f;

        [UIView animateWithDuration:1.2 animations:^{
            self.datePickerSettings.alpha = 0.f;
            self.cityPickerSettings.alpha = 0.0f;

            self.btnSettings.alpha = 1.f;
        } completion:^(BOOL finished) {
            
        }];
        NSDate * choise = [self.datePickerSettings date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd.MM.yyyy"];
        NSString *myDayString = [df stringFromDate:choise];
        self.dateSettings.text = myDayString;
        
    }else if(statusSettings == 2){
        self.goodBtnOtl.alpha =0.f;
        [self.cityPickerSettings reloadAllComponents];
        [UIView animateWithDuration:1.2 animations:^{
            self.datePickerSettings.alpha = 0.f;
            self.cityPickerSettings.alpha = 0.0f;
            self.btnSettings.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
        }];
        self.citySettings.text = strSettings;
    }
    
}

-(void) updateUser:(NSString *)birth_date
              city:(NSString *)city
               sex:(NSString *)sex
              name:(NSString *)name{
    
    
    [[API apiManager] updateUser:birth_date cityId:city sex:sex name:name
     
                       onSuccess:^(NSDictionary *responseObject) {
                           
                           [self.activityIndicator stopAnimating];
                           self.activityIndicator.alpha = 0.f;
                           [self.view setUserInteractionEnabled:YES];
                           
                           
                           NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                           [userDefaults setObject:birth_date forKey:@"birth_date"];
                           [userDefaults setObject:self.citySettings.text forKey:@"city"];
                           [userDefaults setObject:sex forKey:@"sex"];
                           [userDefaults setObject:name forKey:@"name"];
                           
                           messageAlerts = @"Изменения успешно приняты";
                           [self alerts];
                                                      
                       }
     
                       onFailure:^(NSError *error, NSInteger statusCode) {
                           
                           
                           
                           [self.activityIndicator stopAnimating];
                           self.activityIndicator.alpha = 0.f;
                           [self.view setUserInteractionEnabled:YES];
                           
                           NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                           
                           
                           NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                           id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                           
                           NSLog(@"erro: \n%@",json);
                           messageAlerts = [json objectForKey:@"message"];
                           [self alerts];
                           
                           
                       }];
    
}

- (IBAction)nameActText:(id)sender {
    self.nameTextOtl.textColor = [UIColor darkGrayColor];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.datePickerSettings.alpha = 0.0f;
        self.cityPickerSettings.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        
    }];


    
}
- (IBAction)actBtnSettings:(id)sender {
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"%@\n%@\n%@\n%@", self.nameTextOtl.text , self.citySettings.text, [userDefaults objectForKey:@"sex"], self.dateSettings.text);
    
    [self updateUser:self.dateSettings.text city:idCitySettings sex:[userDefaults objectForKey:@"sex"] name:self.nameTextOtl.text];
    
}


@end
