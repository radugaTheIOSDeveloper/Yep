//
//  DetailTable.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "DetailTable.h"
#import "API.h"

@interface DetailTable ()
@property (strong, nonatomic) NSString * messageAlert;

@end

@implementation DetailTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    
    [self backButton];
    
    [self bids];
}


-(void) bids {
    
    [[API apiManager]bidsDetail:self.strID onSuccess:^(NSDictionary *responceObject) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"detail = %@",responceObject);
        

        NSDictionary * arr = [responceObject objectForKey:@"offer_place"];
        NSDictionary * arrcat = [arr objectForKey:@"category"];
        
        self.name.text = [arr objectForKey:@"name"];
        self.description_detail.text = [arr objectForKey:@"description"];
        self.address.text = [arr objectForKey:@"address"];
        self.offer_text.text = [responceObject objectForKey:@"offer_text"];
        self.labelCategory.text =[arrcat objectForKey:@"cat_name"];

        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        [self alerts];
    }];
    
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {
    [self performSegueWithIdentifier:@"backTable" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка загруки"
                                 message:@""
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                }];
    
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)backTable:(id)sender {
    
    [self performSegueWithIdentifier:@"backTable" sender:self];

}


#pragma mark bidAccept

-(void) accept_bids:(NSString *)bid_id{
    
    [[API apiManager] accept_bids:bid_id onSuccess:^(NSDictionary *responseObject) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"%@",self.strID);
        
        [self performSegueWithIdentifier:@"goodDetail" sender:self];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        [self alerts];
    }];
    
}

- (IBAction)actAccept:(id)sender {
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    
    [self accept_bids:self.strID];
    
}
@end
