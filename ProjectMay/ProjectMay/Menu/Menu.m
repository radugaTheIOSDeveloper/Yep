//
//  Menu.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "Menu.h"

@interface Menu ()
{
    NSArray *menuItems;
    
}

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton = YES;
//
    self.navigationItem.title = @"YEP";
//

    [self backButton];
    
    
    menuItems = @[@"list", @"settings", @"friend",@"share",@"exit"];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menuItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    

}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CloseBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.rightBarButtonItem = btn;
    
    
}

- (void)backTapped:(id)sender {
    [self performSegueWithIdentifier:@"closeMenu" sender:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
