//
//  RootViewController.h
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface RootViewController : UIViewController <UIPageViewControllerDataSource>
- (IBAction)regButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;

@end
