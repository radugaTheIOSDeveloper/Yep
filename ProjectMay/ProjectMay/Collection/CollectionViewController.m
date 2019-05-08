//
//  CollectionViewController.m
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"

@interface CollectionViewController ()
{
    NSArray * imgCollection;
    
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imgCollection = @[@"Collection",@"Collection",@"Collection",@"Collection",@"Collection",@"Collection",@"Collection"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imgCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ideActive = @"cell";

    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ideActive forIndexPath:indexPath];
    
    self.collectioView.scrollEnabled = YES;
    
    cell.collectionImages.image = [UIImage imageNamed:imgCollection[indexPath.row]];
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selected = [imgCollection objectAtIndex:indexPath.row];
    NSLog(@"selected=%@", selected);
    [self performSegueWithIdentifier:@"selectedCollectionViewCell" sender:self];

}

@end

