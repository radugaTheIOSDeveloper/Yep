//
//  DetailTable.m
//  ProjectMay
//
//  Created by User on 06.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "DetailTable.h"
#import "API.h"

@interface DetailTable (){
    UITapGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
}

@property (strong, nonatomic) NSString * messageAlert;
@property (strong, nonatomic) UIButton * addBtn;
@property (strong, nonatomic) UIButton * testBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic)  UIProgressView *progressView;
@property (strong, nonatomic) UIView * mView;
@property NSTimer * myTimer;


@end

@implementation DetailTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.alpha = 0.f;
    
    [self.view addSubview:self.activityIndicator];
    
    
    isFullScreen = FALSE;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];
    tap.delegate = self;
    self.view.backgroundColor = [UIColor purpleColor];

//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 -50 , self.view.frame.size.height/2 + 150, 100, 100)];
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [_imageView setClipsToBounds:YES];
//    _imageView.userInteractionEnabled = YES;
//    _imageView.image = [UIImage imageNamed:@"AddButton"];
//
//    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen:)];
//    tapper.numberOfTapsRequired = 1;
//
//    [_imageView addGestureRecognizer:tapper];
//
//    [self.view addSubview:_imageView];
//
//        NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-50];
//        [self.view addConstraint:blueTop];
//
//        NSLayoutConstraint *center = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:1];
//        [self.view addConstraint:center];

    
 
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.trackTintColor = [UIColor whiteColor];
    self.progressView.progressTintColor = [UIColor redColor];
    
//    [_imageView  addSubview:self.progressView];
    

    
    
    
    self.activityIndicator.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2);
    self.activityIndicator.color = [UIColor colorWithRed:108/255.0f green:196/255.0f blue:207/255.0f alpha:1];
    [self.view setUserInteractionEnabled:YES];
    
    self.imageType.image = [UIImage imageNamed:self.imageName];
    
    NSLog(@"image name %@",self.imageName);
    

    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    
    [self.view setUserInteractionEnabled:NO];
    
    
    UIBarButtonItem *button2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
        self.navigationItem.leftBarButtonItem = button2;
       self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
  //  [self backButton];
    
    [self bids];
    
}

-(void)imgToFullScreen:(UITapGestureRecognizer*)sender {
    
    
 //   if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            
            
            _imageView.image =[UIImage imageNamed:@"BackgroundHelp"];
            prevFrame = _imageView.frame;
            [_imageView setFrame:[[UIScreen mainScreen] bounds]];
            self.progressView.frame = CGRectMake(1, 1, _imageView.frame.size.width, 100);
            
            
        }completion:^(BOOL finished){
            
            isFullScreen = TRUE;
            if (@available(iOS 10.0, *)) {
                self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.025 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    static int count = 0;
                    count ++;
                    if (count <= 100) {
                        
                        [self.progressView setProgress:(float)(count/100.0f) animated:YES];
                    }else{
                        [self.myTimer invalidate];
                        self.myTimer = nil;
                        [self.progressView setProgress:(float)(0) animated:NO];
                        count = 0;
                        [self finish];
                    }
                    
                }];
            } else {
                
            }
            
            
        }];
        
        return;

   
}


-(void)finish{
    
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        _imageView.image =[UIImage imageNamed:@"AddButton"];
        
        [_imageView setFrame:prevFrame];
    }completion:^(BOOL finished){
        isFullScreen = FALSE;
    }];
    return;

}

-(void) bids {
    
    [[API apiManager]bidsDetail:self.strID onSuccess:^(NSDictionary *responceObject) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"detail = %@",responceObject);
        

        NSDictionary * arr = [responceObject objectForKey:@"place"];
        NSDictionary * arrcat = [arr objectForKey:@"category"];
        
        self.name.text = [arr objectForKey:@"name"];
        self.description_detail.text = [arr objectForKey:@"description"];
        self.address.text = [arr objectForKey:@"address"];
        self.offer_text.text = [responceObject objectForKey:@"text"];
        self.labelCategory.text =[arrcat objectForKey:@"cat_name"];
        
        NSLog(@"%@", arrcat);
        
        
        NSString * url_img = [NSString stringWithFormat:@"http://188.227.18.52:8000%@",[arr objectForKey:@"image"]];

        NSURL *imagePostURL = [NSURL URLWithString:url_img];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:imagePostURL];

        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

            UIImage *postImage = [UIImage  imageWithData:data];

          self.ImageDetail.image = postImage;
        }];
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        [self alerts];
    }];
    
}

-(void) backButton {
    
    UIBarButtonItem * btn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"BackWhite"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem = btn;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) alerts{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ошибка загруки"
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

- (IBAction)backTable:(id)sender {
    
    self.activityIndicator.alpha = 1.f;
    [self.activityIndicator startAnimating];
    [self cancelBid];
}



-(void) cancelBid {
    
    [[API apiManager] cancel_bid:self.strID
                       onSuccess:^(NSDictionary *responseObject) {
                           
                           self.activityIndicator.alpha = 0.f;
                           [self.activityIndicator stopAnimating];
                           
                           UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                                                                                                                        UIViewController *pvc = [mainStoryboard instantiateViewControllerWithIdentifier:@"navController"];
                                                                                                                                                        pvc.modalPresentationStyle = UIModalPresentationFullScreen;
                                   
                                                                              [self presentViewController:pvc animated:YES completion:nil];
                           
                       } onFailure:^(NSError *error, NSInteger statusCode) {
                           
                           [self.activityIndicator stopAnimating];
                           self.activityIndicator.alpha = 0.f;

                           NSString * errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                           
                           
                           NSData *data = [errResponse dataUsingEncoding:NSUTF8StringEncoding];
                           id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                           
                           NSLog(@"%@",[json objectForKey:@"message"]);
                           
                           
                           NSLog(@"12312312");
                       }];
    

}

#pragma mark bidAccept

-(void) accept_bids:(NSString *)bid_id{
    
    [[API apiManager] accept_bids:bid_id onSuccess:^(NSDictionary *responseObject) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        
        NSLog(@"%@",self.strID);
        
        [self performSegueWithIdentifier:@"goodDetail" sender:self];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        [self.activityIndicator stopAnimating];
        self.activityIndicator.alpha = 0.f;
        [self.view setUserInteractionEnabled:YES];
        [self alerts];
    }];
    
}

- (IBAction)actAccept:(id)sender {
    
    [self.activityIndicator startAnimating];
    self.activityIndicator.alpha = 1.f;
    [self.view setUserInteractionEnabled:NO];
    
    [self accept_bids:self.strID];
    
}
@end
