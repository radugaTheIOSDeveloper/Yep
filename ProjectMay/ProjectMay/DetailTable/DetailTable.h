//
//  DetailTable.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTable : UIViewController <UIGestureRecognizerDelegate>

- (IBAction)backTable:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ImageDetail;

@property (weak, nonatomic) IBOutlet UIImageView *imageType;


@property (weak, nonatomic) IBOutlet UILabel *labelCategory;
@property (strong, nonatomic) NSString * strID;
@property (strong, nonatomic) NSString * imageName;


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UITextView *description_detail;
@property (weak, nonatomic) IBOutlet UITextView *offer_text;
- (IBAction)actAccept:(id)sender;

@end
