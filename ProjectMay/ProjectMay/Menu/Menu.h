//
//  Menu.h
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Menu : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *iconMale;
@property (weak, nonatomic) IBOutlet UILabel *nameMenu;
@property (weak, nonatomic) IBOutlet UILabel *cityMenu;

@end
