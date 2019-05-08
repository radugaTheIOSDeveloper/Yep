//
//  ListHistory.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "ListHistory.h"

@interface ListHistory ()
{
    NSArray * arrImg;
    
}
@end

@implementation ListHistory

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrImg = @[@"Z2",@"Z2",@"Z2",@"Z2",@"Z2"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

        return arrImg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ideCell = @"cellof";
    
    self.tableView.scrollEnabled = NO;
    UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideCell];
    UIImageView * image = (UIImageView *)[cellACtive.contentView viewWithTag:20];
    UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:21];
    UILabel * detail = (UILabel *)[cellACtive.contentView viewWithTag:22];
    UILabel * date = (UILabel *)[cellACtive.contentView viewWithTag:23];
    UIImageView * imageTwo = (UIImageView *)[cellACtive.contentView viewWithTag:24];
    
    image.image = [UIImage imageNamed:@"Z2"];
    imageTwo.image = [UIImage imageNamed:@"NextImg"];
    detail.textColor = [UIColor lightGrayColor];
    
    nameSam.text = @"Заголовок";
    detail.text = @"Детальная информация";
    date.text = @"10:08";
    
    return cellACtive;
}


@end
