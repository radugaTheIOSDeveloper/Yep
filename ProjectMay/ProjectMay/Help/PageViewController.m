//
//  PageViewController.m
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()
{
    NSArray * devices;
}

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    devices = [NSArray arrayWithObjects:@"InstBackgound1", @"InstBackgound2", @"InstBackgound3", @"InstBackgound4", nil];
    self.dataSource = self;
    MyHelp * hViewController =  (MyHelp *)[self viewControllerAtIndex:0];
    NSArray * viewControllers = [NSArray arrayWithObject:hViewController];
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(MyHelp *) viewControllerAtIndex: (NSUInteger )index{
    
    MyHelp * helpViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyHelp"];
    
    
    helpViewController.strImage = devices[index];
    helpViewController.pageIndex = index;
    
    return helpViewController;
}

- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerBeforeViewController: (UIViewController *)viewController{
    NSUInteger index = ((MyHelp *) viewController).pageIndex;
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex: index];
}
- (UIViewController *)pageViewController: (UIPageViewController *)pageViewController viewControllerAfterViewController: (UIViewController *)viewController{
    NSUInteger index = ((MyHelp *) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == devices.count) {
        return nil;
    }
    return [self viewControllerAtIndex: index];
}

@end
