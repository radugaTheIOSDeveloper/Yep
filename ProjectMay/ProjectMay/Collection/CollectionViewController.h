//
//  CollectionViewController.h
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectioView;

//-(void) refreshView: (UIRefreshControl *) refresh;
//@property (strong, nonatomic) UIRefreshControl * refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;


@end
