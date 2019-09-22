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
@property (strong, nonatomic)NSString * bidsID;

-(void) setToken:(NSString *)token;
-(NSString *) getToken;

-(void) setBidsID:(NSString *)bidsID;
-(NSString *) getBidsID;

-(void) setExisting_user:(NSString *)existing_user;
-(NSString *) getExisting_user;

-(void) confirmOnetimePass:(NSString *)numPhone
                      onetime_pass:(NSString *)onetime_pass
                 onSuccess:(void(^)(NSDictionary * responseObject)) success
                 onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) updateUser:(NSString *)birth_date
            cityId:(NSString *)cityId
               sex:(NSString *)sex
              name:(NSString *)name
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) bids:(NSString *)category
                wish:(NSString *)wish
               wish_date:(NSString *)wish_date
         onSuccess:(void(^)(NSDictionary * responseObject)) success
         onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) onetimePass:(NSString *)numPhone
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) citys:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) categories:(void(^)(NSDictionary * responseObject)) success
    onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;

-(void) getCitys:(void(^)(NSDictionary * responceObject))success
               onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;

#pragma mark bids

-(void) bidsList:(void(^)(NSDictionary * responceObject))success
       onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;

-(void) bidsDetail:(NSString*)idTable
         onSuccess:(void(^)(NSDictionary * responceObject))success
       onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;


-(void) accept_bids:(NSString *)bid_id
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) cancel_bid:(NSString *)bid_id
          onSuccess:(void(^)(NSDictionary * responseObject)) success
          onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure;


-(void) archiveList:(void(^)(NSDictionary * responceObject))success
       onFailure:(void(^)(NSError * error, NSInteger statusCode))failure;


@end
