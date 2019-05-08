//
//  NextDetail.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextDetail : UIViewController
- (IBAction)yourWish:(id)sender;
- (IBAction)nextBtn:(id)sender;
- (IBAction)dateOrder:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *otlDateOrder;
@property (weak, nonatomic) IBOutlet UITextField *otlYourWih;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@end
