//
//  DetailTable.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTable : UIViewController

- (IBAction)backTable:(id)sender;

@property (strong, nonatomic) NSString * strID;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UITextView *description_detail;
@property (weak, nonatomic) IBOutlet UITextView *offer_text;

@end
