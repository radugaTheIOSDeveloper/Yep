//
//  PageContentController.h
//  ProjectMay
//
//  Created by User on 28.04.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageLogo;
@property NSString *imageName;

@property NSUInteger pageIndex;

@end
