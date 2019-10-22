//
//  Menu.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "Menu.h"
#import "API.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>

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


    
    self.navigationItem.title = @"YEP";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSFontAttributeName:[UIFont fontWithName:@"AmaticSC-Bold" size:34]}];
    
//


    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[userDefaults objectForKey:@"city"]);

    
    
    if ([[userDefaults objectForKey:@"sex"] isEqualToString:@"F"]) {

        self.iconMale.image = [UIImage imageNamed:@"female"];

    } else if ([[userDefaults objectForKey:@"sex"] isEqualToString:@"M"]){
        self.iconMale.image = [UIImage imageNamed:@"male"];
    } else{
        self.iconMale.image = [UIImage imageNamed:@"male"];
    }

    self.nameMenu.text = [userDefaults objectForKey:@"name"];
    self.cityMenu.text = [userDefaults objectForKey:@"city"];
    
    menuItems = @[@"list", @"settings", @"friend",@"share",@"exit"];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self backButton];
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
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([[menuItems objectAtIndex:indexPath.row] isEqualToString:@"share"]) {
        NSLog(@"goood share");
        [self actSocial];
    }
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;

    NSString * strrow = [menuItems objectAtIndex:indexPath.row];
    
    NSLog(@"row name  -  %@", [menuItems objectAtIndex:indexPath.row] );

    if ([strrow isEqualToString:@"list"]) {
        
        
        destViewController.title = [@"Архив заявок" capitalizedString];
        
    }else if ([strrow isEqualToString:@"settings"]){
        destViewController.title = [@"Настройки" capitalizedString];


    } else if ([strrow isEqualToString:@"exit"]){
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"login" forKey:@"token"];
        [[API apiManager]setToken:NULL];
    }
   // destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];

}



- (void) actSocial {
    
    NSString * message = @"Тестовый текс тестовый текст \n ntcrcnjds fasf";
    
    UIImage * image = [UIImage imageNamed:@"social"];
    
    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    
    [self presentViewController:avc animated:YES completion:nil];
    
    

    
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CloseBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.rightBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor purpleColor];

    
}

- (void)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

    //[self performSegueWithIdentifier:@"closeMenu" sender:self];
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
