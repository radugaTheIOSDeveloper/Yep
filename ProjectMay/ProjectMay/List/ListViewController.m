//
//  ListViewController.m
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "ListViewController.h"
#import <Security/Security.h>
#import <KeychainItemWrapper.h>
#import "API.h"
#import "DetailTable.h"
@interface ListViewController ()
{
    NSArray * arrImg;
}

@property (strong, nonatomic) UIButton * addBtn;
@property (strong, nonatomic) NSMutableArray * hotList;
@property (strong, nonatomic) NSMutableArray * list;
@property (strong, nonatomic) NSMutableArray * short_desc;
@property (strong, nonatomic) NSMutableArray * offer_type;

@property (strong, nonatomic) NSMutableArray * idl;

@property (strong, nonatomic) NSString  * idTable;

@property (strong, nonatomic) NSString  * stringTypes;



@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrImg = @[@"Z1",@"Z1",@"Z1",@"Z1",@"Z1",@"Z2",@"Z2",@"Z2",@"Z2",@"Z2",@"Z2"];
    
    self.hotList = [NSMutableArray array];
    self.list = [NSMutableArray array];
    self.short_desc = [NSMutableArray array];
    self.offer_type = [NSMutableArray array];
    self.idl = [NSMutableArray array];
    



    
    NSLog(@"%@", [[API apiManager]getToken]);
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.addBtn.frame = CGRectMake(self.view.frame.size.width/2 -50 , self.view.frame.size.height/2 + 150, 100, 100);
    [self.addBtn addTarget:self action:@selector(addBtnActn:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"AddButton"] forState:UIControlStateNormal];
    self.addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.addBtn];

    NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    [self.view addConstraint:blueTop];

        NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:1];
    [self.view addConstraint:center];

    if (arrImg == 0) {
    
        self.tableView.alpha = 0;
        
        UIImageView * img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"Z3"];
        img.frame = CGRectMake(self.view.frame.size.width/2 -170 , self.view.frame.size.height/2 - 90 , 340, 180);

        [self.view addSubview:img];
        
    }
    
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];

    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    
    
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    
    [self getBids];
    
}


-(void) stopActivityIndicator{
    
    self.activityIndicator.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];
    [self.activityIndicator stopAnimating];
    
}



-(void) refreshView: (UIRefreshControl *) refresh{
    
    [self getBids];
}





#pragma marks api

-(void)getBids{
    
    [[API apiManager] bidsList:^(NSDictionary *responceObject) {
        
        [self stopActivityIndicator];
        [self.refreshControl endRefreshing];

        NSLog(@"%@",responceObject);
        NSMutableArray * active = [responceObject valueForKey:@"place"];
        self.hotList = active;
        
        NSMutableArray * short_desc = [responceObject valueForKey:@"short_desc"];
        self.short_desc = short_desc;
        
        NSMutableArray * idl = [responceObject valueForKey:@"id"];
        self.idl = idl;
        
        NSMutableArray * offer_type = [responceObject valueForKey:@"otype"];
        self.offer_type = offer_type;

        NSLog(@"%ld, %ld" ,[self.hotList count], [self.short_desc  count]);
        
        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self stopActivityIndicator];
        [self.refreshControl endRefreshing];

        NSLog(@"%@",error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat crenHaight = screenRect.size.height;
    
    if ([self.hotList count] == 0) {
        return crenHaight;
    }else{
        return 80.f;
    }
    return crenHaight;

}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  
    NSLog(@"%ld", [self.hotList count]);

    if ([self.hotList count] == 0) {
        return 1;
    }else{
        return [self.hotList count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ideCell = @"activeCell";
    static NSString * idecellnull = @"cellnull";

    
    
    if ([self.hotList count] == 0) {

        UITableViewCell * cellnull = [tableView dequeueReusableCellWithIdentifier:idecellnull];
        self.tableView.scrollEnabled = YES;
       // self.tableView.allowsSelection = YES;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        return cellnull;
    
    }else{

    
        self.tableView.scrollEnabled = YES;
        self.tableView.allowsSelection = YES;
     //   self.tableView.backgroundColor = [UIColor whiteColor];
      //  self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideCell];
        UIImageView * image = (UIImageView *)[cellACtive.contentView viewWithTag:10];
        UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:11];
        UILabel * detail = (UILabel *)[cellACtive.contentView viewWithTag:12];
        UIImageView * imageTwo = (UIImageView *)[cellACtive.contentView viewWithTag:14];

        NSDictionary * hot = [self.hotList objectAtIndex:indexPath.row];

    
    NSString * stsr = [NSString stringWithFormat:@"%@", [self.offer_type objectAtIndex:indexPath.row]];
    NSLog(@"%@",stsr);
    

    if ([stsr isEqualToString:@"1"]) {
        image.image = [UIImage imageNamed:@"Z1"];
        self.stringTypes = @"Z1";
    }else{
        image.image = [UIImage imageNamed:@"Z2"];
        self.stringTypes = @"Z2";


    }
    
        imageTwo.image = [UIImage imageNamed:@"NextHotImg"];
        nameSam.text = [hot objectForKey:@"name"];
        detail.text = [self.short_desc objectAtIndex:indexPath.row];
        
    return cellACtive;

    }
        return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    self.idTable = [NSString stringWithFormat:@"%@",[self.idl objectAtIndex:indexPath.row]];
    
    
    
    
    [self performSegueWithIdentifier:@"detail" sender:self];

}


-(void)addBtnActn:(UIButton *)sender {
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navControlls"];
    pvc.modalPresentationStyle = UIModalPresentationFullScreen;
           
    [self presentViewController:pvc animated:YES completion:nil];
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    DetailTable * seguesms;
    if ([[segue identifier] isEqualToString:@"detail"]){
        
        seguesms = [segue destinationViewController];
        seguesms.strID = self.idTable;
        seguesms.imageName = self.stringTypes;
        
    }
}

@end
