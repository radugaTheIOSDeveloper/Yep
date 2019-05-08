//
//  ListViewController.m
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

{
    NSArray * arrImg;

}

@property (strong, nonatomic) UIButton * addBtn;



@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arrImg = @[@"Z1",@"Z1",@"Z1",@"Z1",@"Z1",@"Z2",@"Z2",@"Z2",@"Z2",@"Z2",@"Z2"];
    
    
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(self.view.frame.size.width/2 -50 , self.view.frame.size.height/2 + 220, 100, 100);
    [self.addBtn addTarget:self action:@selector(addBtnActn:) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"AddButton"] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    
    
    if (arrImg == 0) {
        
        self.tableView.alpha = 0;
        
        
        UIImageView * img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"Z3"];
        img.frame = CGRectMake(self.view.frame.size.width/2 -170 , self.view.frame.size.height/2 - 90 , 340, 180);

        
        
        [self.view addSubview:img];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (arrImg.count == 0) {
        return 0;
    }else{
        return arrImg.count;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ideCell = @"activeCell";
    static NSString * ideCellNull = @"cellNull";

    
//    if (arrImg.count == 0) {
//
//        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideCellNull];
//        self.tableView.scrollEnabled = NO;
//        self.tableView.allowsSelection = NO;
//        self.tableView.backgroundColor = [UIColor clearColor];
//
//
//        return cellACtive;
    
//    }else{
        NSString * str = [arrImg objectAtIndex:indexPath.row];
        
        self.tableView.scrollEnabled = YES;
        self.tableView.allowsSelection = YES;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideCell];
        UIImageView * image = (UIImageView *)[cellACtive.contentView viewWithTag:10];
        UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:11];
        UILabel * detail = (UILabel *)[cellACtive.contentView viewWithTag:12];
        UILabel * date = (UILabel *)[cellACtive.contentView viewWithTag:13];
        UIImageView * imageTwo = (UIImageView *)[cellACtive.contentView viewWithTag:14];
        
        
        if ([str isEqualToString:@"Z1"]) {
            
            
            image.image = [UIImage imageNamed:@"Z1"];
            imageTwo.image = [UIImage imageNamed:@"NextHotImg"];
            nameSam.textColor = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
            detail.textColor = [UIColor lightGrayColor];
            
        }else{
            image.image = [UIImage imageNamed:@"Z2"];
            imageTwo.image = [UIImage imageNamed:@"NextImg"];
            detail.textColor = [UIColor lightGrayColor];
            
        }
        
        
        
        
        nameSam.text = @"Заголовок";
        detail.text = @"Детальная информация";
        date.text = @"10:08";
        
//        return cellACtive;
//
//    }
    
    
 
    
//    imageCoin.image = [UIImage imageNamed:@"coinPast"];
//    nameSam.textColor = [UIColor colorWithRed:111/255.0f green:113/255.0f blue:121/255.0f alpha:1];
//    nameSam.text = [curCoinActive objectForKey:@"minutes_str"];
//    date.text = [curCoinActive objectForKey:@"pay_date"];
    
    return cellACtive;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"detail" sender:self];

}


-(void)addBtnActn:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"collection" sender:self];
}

@end
