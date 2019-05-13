//
//  API.h
//  Yep
//
//  Created by User on 12.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface API : NSObject
+(API*) apiManager;
@property (strong, nonatomic) AFHTTPSessionManager * sessionManager;

-(void) confirmOnetimePass:(NSString *)numPhone
                      onetime_pass:(NSString *)onetime_pass
                 onSuccess:(void(^)(NSDictionary * responseObject)) success
                 onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) onetimePass:(NSString *)numPhone
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;
@end
