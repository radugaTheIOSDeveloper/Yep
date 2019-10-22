//
//  GoodDetail.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "GoodDetail.h"

@interface GoodDetail ()

@end

@implementation GoodDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton = YES;
    
    
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CloseBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
        self.navigationItem.leftBarButtonItem = button2;
       self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

//-(void) backButton {
//    
//    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"CloseBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
//    self.navigationItem.rightBarButtonItem = btn;
//    
//  //  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//}

- (void)backTapped:(id)sender {
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                                                                              UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navController"];
                                                                                                                              pvc.modalPresentationStyle = UIModalPresentationFullScreen;
         
                                                    [self presentViewController:pvc animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)gAct:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                                                                              UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navController"];
                                                                                                                              pvc.modalPresentationStyle = UIModalPresentationFullScreen;
         
                                                    [self presentViewController:pvc animated:YES completion:nil];
}
@end
