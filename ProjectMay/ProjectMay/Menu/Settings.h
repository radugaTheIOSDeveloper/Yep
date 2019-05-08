//
//  Settings.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings : UIViewController <UITextFieldDelegate>

//property outlet
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *mail;

@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *fllor;

@property (weak, nonatomic) IBOutlet UILabel *sity;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textMail;
@property (weak, nonatomic) IBOutlet UIButton *ageBtn;
@property (weak, nonatomic) IBOutlet UIButton *sityBtn;
@property (weak, nonatomic) IBOutlet UIButton *menOtl;
@property (weak, nonatomic) IBOutlet UIButton *woomenOtl;

//property action
- (IBAction)nameTextAct:(id)sender;

- (IBAction)mailTextAction:(id)sender;
- (IBAction)men:(id)sender;
- (IBAction)woomen:(id)sender;

- (IBAction)ageAct:(id)sender;
- (IBAction)cityAct:(id)sender;


@end
