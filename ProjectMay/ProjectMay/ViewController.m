//
//  ViewController.m
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSString * tokenStatus;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.logoImage.alpha = 0.f;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    _tokenStatus = [userDefaults objectForKey:@"token"];
    NSLog(@"наш токен рапвен %@", [userDefaults objectForKey:@"token"]);

    [UIView animateWithDuration:1.6 animations:^{
        self.logoImage.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:2.2 animations:^{
            CGRect newLogoFrame = self.logoImage.frame;
            newLogoFrame.origin.y= 60.0f; 
            self.logoImage.frame=newLogoFrame;
            
        } completion:^(BOOL finished) {
            

            if ([_tokenStatus isEqualToString:@"true"]) {
                
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navController"];
                            pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                            [self presentViewController:pvc animated:YES completion:nil];
                
                
                
            }else if ([_tokenStatus isEqualToString:@"login"]){
                
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
                pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:pvc animated:YES completion:nil];
                
            }else {
                
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"rootViewController"];
                pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                [self presentViewController:pvc animated:YES completion:nil];
                

            }
            
//            }else if([_tokenStatus isEqualToString:@"false"]){
//                [self performSegueWithIdentifier:@"loginfull" sender:self];
//            }
                
        }];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
