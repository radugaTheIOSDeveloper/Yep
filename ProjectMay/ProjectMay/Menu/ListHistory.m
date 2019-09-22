//
//  ListHistory.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "ListHistory.h"
#import "API.h"

@interface ListHistory ()

@property (strong, nonatomic) NSMutableArray * hotList;
@property (strong, nonatomic) NSMutableArray * list;
@property (strong, nonatomic) NSMutableArray * short_desc;
@property (strong, nonatomic) NSMutableArray * offer_type;
@property (strong, nonatomic) NSMutableArray * idl;
@property (strong, nonatomic) NSString  * stringTypes;


@end

@implementation ListHistory

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    
    
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self.activityIndicator startAnimating];
    [self getArchive];
}


-(void)getArchive{
    
    [[API apiManager] archiveList:^(NSDictionary *responceObject) {
        
        [self stopActivityIndicator];
        
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
        
        NSLog(@"%@",error);
    }];
    
    
}

-(void) stopActivityIndicator{
    
    self.activityIndicator.alpha = 0.f;
    [self.view setUserInteractionEnabled:YES];
    [self.activityIndicator stopAnimating];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.hotList count] == 0) {
        return 44.f;
    }else{
        return 80.f;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.hotList.count == 0) {
        
        return 1;
        
    }else{
        return self.hotList.count;

    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * ideCell = @"cellof";
    static NSString * nullCell = @"cellNullArchive";
    self.tableView.scrollEnabled = NO;
    self.tableView.allowsSelection = NO;
    
    if (self.hotList.count == 0) {
        UITableViewCell * cellnull = [tableView dequeueReusableCellWithIdentifier:nullCell];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UILabel * zLabel = (UILabel *)[cellnull.contentView viewWithTag:420];
        zLabel.text = @"Заявки в архиве отсутствуют";
        
        
        return cellnull;
    }else{
        UITableViewCell * cellACtive = [tableView dequeueReusableCellWithIdentifier:ideCell];
        UIImageView * image = (UIImageView *)[cellACtive.contentView viewWithTag:20];
        UILabel * nameSam = (UILabel *)[cellACtive.contentView viewWithTag:21];
        UILabel * detail = (UILabel *)[cellACtive.contentView viewWithTag:22];
        
        NSDictionary * hot = [self.hotList objectAtIndex:indexPath.row];
        
        
        NSString * stsr = [NSString stringWithFormat:@"%@", [self.offer_type objectAtIndex:indexPath.row]];
        NSLog(@"%@",stsr);
        
        
        if ([stsr isEqualToString:@"1"]) {
            image.image = [UIImage imageNamed:@"Z5"];
            self.stringTypes = @"Z5";
        }else{
            image.image = [UIImage imageNamed:@"Z6"];
            self.stringTypes = @"Z6";
        }

        nameSam.text = [hot objectForKey:@"name"];
        detail.text = [self.short_desc objectAtIndex:indexPath.row];
        
        return cellACtive;

    }
    
    return NULL;

    
}


@end
