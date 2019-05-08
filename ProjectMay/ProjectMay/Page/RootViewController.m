//
//  RootViewController.m
//  ProjectMay
//
//  Created by User on 29.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageImages = @[@"InstBackgound1", @"InstBackgound2", @"InstBackgound3", @"InstBackgound4"];
    
    
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundHelp"]];
//    imageView1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [view addSubview:imageView1];

    self.pageViewController = [self.storyboard
                instantiateViewControllerWithIdentifier:@"PageController"];
    self.pageViewController.dataSource = self;

//    self.pageViewController.view.backgroundColor = [UIColor clearColor];
//    [self.pageViewController.view insertSubview:view atIndex:0];


    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];

   [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 30);


    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex: index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageImages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageImages count] == 0) || (index >= [self.pageImages count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    pageContentViewController.view.backgroundColor = [UIColor clearColor];

    return pageContentViewController;
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (IBAction)regButton:(id)sender {
    
    [self performSegueWithIdentifier:@"auth" sender:self];

}
@end
