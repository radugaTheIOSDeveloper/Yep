//
//  Settings.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@end

@implementation Settings

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dismissKeyboard{
    
    [self.textName resignFirstResponder];
    [self.textMail resignFirstResponder];
}

- (IBAction)nameTextAct:(id)sender {
}

- (IBAction)mailTextAction:(id)sender {
}

- (IBAction)men:(id)sender {
    
    [self.menOtl setImage:[UIImage imageNamed:@"RadioActive"] forState:UIControlStateNormal];
    [self.woomenOtl setImage:[UIImage imageNamed:@"RadioInactive"] forState:UIControlStateNormal];

}

- (IBAction)woomen:(id)sender {
    
        [self.woomenOtl setImage:[UIImage imageNamed:@"RadioActive"] forState:UIControlStateNormal];
        [self.menOtl setImage:[UIImage imageNamed:@"RadioInactive"] forState:UIControlStateNormal];

  
}

- (IBAction)ageAct:(id)sender {
}

- (IBAction)cityAct:(id)sender {
}
@end
