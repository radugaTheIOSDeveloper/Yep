//
//  PageViewController.h
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHelp.h"

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) PageViewController * pageViewController;
@property (strong, nonatomic) MyHelp * hViewController;

@end
