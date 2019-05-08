//
//  SkipClass.h
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentController.h"

@interface SkipClass : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *pageImages;





@property (weak, nonatomic) IBOutlet UIButton *regBtn;
- (IBAction)actRegBtn:(id)sender;

@end
