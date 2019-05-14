//
//  FinalRegistration.m
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "FinalRegistration.h"

@interface FinalRegistration ()

@end

NSInteger status;

NSString * str;

@implementation FinalRegistration

@synthesize datePicker;
@synthesize arrayCity;
@synthesize arrayFloor;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayCity = [[NSMutableArray alloc]initWithObjects:@"Тула",
                 @"Москва",@"Челябинск",
                 @"Усурийск",@"Новгород",
                 @"Рязань",@"Уфа",@"Калуга",
                 @"Адлер",@"Ростов", nil];
    
    
    arrayFloor = [[NSMutableArray alloc]initWithObjects:@"Мужской",@"Женский", nil];
    
    
    

    
    self.pickerView.delegate= self;
    self.pickerView.dataSource=self ;
    
    self.sityLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(didTapLabelWithGesturesityLabel:)];
    [self.sityLabel addGestureRecognizer:tapGesture];
    
    self.dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(didTapLabelWithGesturedateLabel:)];
    [self.dateLabel addGestureRecognizer:tapGesture2];

    self.menLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3 =[[UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(didTapLabelWithGesturemenLabel:)];
    [self.menLabel addGestureRecognizer:tapGesture3];
    
    
    self.pickerView.alpha = 0.f;
    datePicker.alpha = 0.f;
    
    
    if (self.pickerView.alpha == 0) {
        self.readyOutlet.alpha = 0;
        self.nt.alpha = 1.f;
        
    }else{
        
        self.nt.alpha = 0.f;
        self.readyOutlet.alpha = 1.f;
    }
    
    
    status = 1;
    
    
    
}



- (void)didTapLabelWithGesturesityLabel:(UITapGestureRecognizer *)tapGesture {
    status = 1;
    self.nt.alpha = 0.f;
    self.readyOutlet.alpha = 1.f;
    self.datePicker.alpha = 0.f;

    [self.pickerView reloadAllComponents];
    
    self.pickerView.alpha = 0.0f;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.pickerView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        
    }];
    
}
- (void)didTapLabelWithGesturedateLabel:(UITapGestureRecognizer *)tapGesture {
    
    
    status = 3;
    
    self.nt.alpha = 0.f;
    self.readyOutlet.alpha = 1.f;
    
    [self.pickerView reloadAllComponents];
    
    self.pickerView.alpha = 0.f;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.datePicker.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)didTapLabelWithGesturemenLabel:(UITapGestureRecognizer *)tapGesture {
    
    status = 2;
    self.nt.alpha = 0.f;
    self.readyOutlet.alpha = 1.f;
    self.datePicker.alpha = 0.f;

    [self.pickerView reloadAllComponents];
    
    self.pickerView.alpha = 0.f;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.pickerView.alpha = 1.0f;
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


  
    
    if (status == 1){
        return  arrayCity.count;

    } else if (status == 2){
        
        return  arrayFloor.count;

    }
    
    return 0;

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    

    if (status == 1) {
        
        return [arrayCity objectAtIndex:row];
    }else if (status == 2){
        return [arrayFloor objectAtIndex:row];

    }
    
    return 0;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    

    
    if (status == 1) {
        str = [arrayCity objectAtIndex:row];
        
    }else if (status == 2){
        
       str = [arrayFloor objectAtIndex:row];

        
    }
 

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)regBtn:(id)sender {
    
    [self performSegueWithIdentifier:@"listViewController" sender:self];

    
}




- (IBAction)readyAction:(id)sender {
    
    
    if (status == 1) {
        self.readyOutlet.alpha =0.f;
        [self.pickerView reloadAllComponents];
        [UIView animateWithDuration:1.2 animations:^{
            self.datePicker.alpha = 0;
            self.pickerView.alpha = 0.0f;
            self.nt.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
        }];
        self.sityLabel.text = str;

    }else if (status == 2){
        self.readyOutlet.alpha =0.f;
        [self.pickerView reloadAllComponents];
        [UIView animateWithDuration:1.2 animations:^{
            self.datePicker.alpha = 0;
            self.pickerView.alpha = 0.0f;
            self.nt.alpha = 1.f;
            
        } completion:^(BOOL finished) {
            
        }];
        self.menLabel.text = str;
        
    }else if (status == 3){
        
        [UIView animateWithDuration:1.2 animations:^{
            self.datePicker.alpha = 0;
            self.nt.alpha = 1.f;
        } completion:^(BOOL finished) {
            
        }];
        NSDate * choise = [datePicker date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd.MM.yyyy"];
        NSString *myDayString = [df stringFromDate:choise];
      //  NSLog(@"%@", myDayString);
        //NSString * date = [[NSString alloc]initWithFormat:@"%@", myDayString];

        self.dateLabel.text = myDayString;
    }
    

    
    
    
    
}



- (IBAction)actName:(id)sender {
}
@end
