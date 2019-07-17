//
//  CollectionViewController.m
//  ProjectMay
//
//  Created by User on 30.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "API.h"
#import "NextDetail.h"


@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableArray * cat_name;
@property (strong, nonatomic) NSMutableArray * cat_id;
@property (strong, nonatomic) NSMutableArray * cat_image;
@property (strong, nonatomic) NSString * idCategory;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    imgCollection = @[@"Collection",@"Collection",@"Collection",@"Collection",@"Collection",@"Collection",@"Collection"];
    
    _cat_name = [NSMutableArray array];
    _cat_id = [NSMutableArray array];
    _cat_image = [NSMutableArray array];

    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    [self.view addSubview:self.activityIndicator];
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view setUserInteractionEnabled:YES];
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    [self categories];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)categories{
    
    [[API apiManager]categories:^(NSDictionary *responseObject) {
        
        
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"%@",responseObject);
        NSMutableArray * name = [responseObject valueForKey:@"cat_name"];
        self.cat_name = name;
        NSMutableArray * idc = [responseObject valueForKey:@"id"];
        self.cat_id = idc;
        NSMutableArray * imagec = [responseObject valueForKey:@"image"];
        self.cat_image = imagec;
        
        [self.collectioView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@",error);
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        [self alerts];
    }];
    
    
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка регистрации!"
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



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cat_id.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ideActive = @"cell";

    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ideActive forIndexPath:indexPath];
    
    self.collectioView.scrollEnabled = YES;
    NSString * url_img = [NSString stringWithFormat:@"http://188.227.18.52:8000%@",[self.cat_image objectAtIndex:indexPath.row]];
        
    NSURL *imagePostURL = [NSURL URLWithString:url_img];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imagePostURL];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        UIImage *postImage = [UIImage  imageWithData:data];
        
        CGFloat widthScale = 50.f / postImage.size.width;
        CGFloat heightScale = 50.f / postImage.size.height;
        
        cell.iconCollectional.transform = CGAffineTransformMakeScale(widthScale, heightScale);
        cell.iconCollectional.image = postImage;
        [cell setNeedsLayout];
    }];
    
    cell.collectionImages.image = [UIImage imageNamed:@"Collection"];
    cell.collectionsLabel.text = [self.cat_name objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selected = [self.cat_id objectAtIndex:indexPath.row];
    NSLog(@"selected=%@", selected);
    _idCategory = selected;
    [self performSegueWithIdentifier:@"selectedCollectionViewCell" sender:self];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    NextDetail * seguesms;
    if ([[segue identifier] isEqualToString:@"selectedCollectionViewCell"]){
        
        seguesms = [segue destinationViewController];
        seguesms.idCat = _idCategory;
        
        
    }
    
}


@end

