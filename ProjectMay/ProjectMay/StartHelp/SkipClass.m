//
//  SkipClass.m
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "SkipClass.h"

@interface SkipClass ()

@end

@implementation SkipClass

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageTitles = @[@"Оплатите жетоны",@"На автомойке САМ",@"Просканируйте QR код",@"Получите жетоны"];
    self.pageImages = @[@"Logo",@"Logo",@"Logo",@"Logo"];

    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyPageController"];
    self.pageViewController.dataSource = self;
    
    PageContentController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.regBtn.alpha = 0.f;
    
    
}


- (PageContentController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    PageContentController *pageContentController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentController"];
    pageContentController.imageName = self.pageImages[index];
    pageContentController.pageIndex = index;
    self.index = index;
    
    if (index == 1) {
        self.regBtn.alpha = 1.f;
    }
    
    
    return pageContentController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)actRegBtn:(id)sender {
}
@end
