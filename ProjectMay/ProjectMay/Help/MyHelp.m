//
//  MyHelp.m
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "MyHelp.h"

@interface MyHelp ()

@end

@implementation MyHelp

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageHelp.image =[UIImage imageNamed:self.strImage];
    
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
