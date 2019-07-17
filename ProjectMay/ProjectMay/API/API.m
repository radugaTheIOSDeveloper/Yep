//
//  API.m
//  Yep
//
//  Created by User on 12.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "API.h"
#import <Security/Security.h>
#import <KeychainItemWrapper.h>

@implementation API


+(API*) apiManager{
    
    static API * manager = nil;
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[API alloc]init];
    });
    return manager;
}

-(id)init{
    self = [super init];
    if (self) {
        NSURL * url = [NSURL URLWithString:@"http://188.227.18.52:8000/api/v0/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}


-(void) setToken:(NSString *) token{
    
    KeychainItemWrapper * wraper = [[KeychainItemWrapper alloc]initWithIdentifier:@"token" accessGroup:nil];
    [wraper setObject:token forKey:(id)kSecValueData];
    // NSLog(@"%@",[wraper objectForKey:(id)kSecValueData]);
    
}

-(NSString *) getToken{
    KeychainItemWrapper * wraper = [[KeychainItemWrapper alloc]initWithIdentifier:@"token" accessGroup:nil];
    return [wraper objectForKey:(id)kSecValueData];
}


-(void)setBidsID:(NSString *)bidsID{
    
    self.bidsID = bidsID;
}

-(NSString *)getBidsID{
    return self.bidsID;
}

-(void)setExisting_user:(NSString *)existing_user{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:existing_user forKey:@"existing_user"];
}

-(NSString * )getExisting_user{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];

    return [userDefaults objectForKey:@"existing_user"];
}


-(void) confirmOnetimePass:(NSString *)numPhone
                      onetime_pass:(NSString *)onetime_pass
                 onSuccess:(void(^)(NSDictionary * responseObject)) success
                 onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"phone",
                             onetime_pass, @"onetime_pass",nil];
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];

    [self.sessionManager POST:@"confirmOnetimePass/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if (success) {
                              success(responseObject);
                              
                              NSLog(@"%@", responseObject);
                          }
                      }
                      failure: ^(NSURLSessionTask *operation, NSError *error) {
                          
                          NSLog(@"operation = %@ \n error =  %@", operation, error);

                          if (failure) {
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}


-(void)onetimePass:(NSString *)numPhone
         onSuccess:(void (^)(NSDictionary *))success
         onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSString * str = [NSString stringWithFormat:@"onetimePass/?phone=%@",numPhone];
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [self.sessionManager GET:str
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                               NSLog(@"Nenenene%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                           NSLog(@"error%@",operation);
                         

                         
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
    
}





-(void)getCitys:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    [self.sessionManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [self.sessionManager GET:@"cities/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                                   NSLog(@"%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                             NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];

    
}

-(void)bids:(NSString *)category
       wish:(NSString *)wish
  wish_date:(NSString *)wish_date
  onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             category, @"category",
                             wish, @"wish",
                             wish_date, @"wish_date",
                             nil];
    
    
    
    NSLog(@"%@",[self getToken]);
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager POST:@"bids/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if(success){
                              success(responseObject);
                              NSLog(@"responce object %@",responseObject);
                          }
                      }
                      failure:^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"error%@",operation);
                          
                          
                          
                          if(failure){
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

#pragma nark categories


-(void) categories:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    [self.sessionManager GET:@"categories/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                             NSLog(@"%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
    
    
}


#pragma mark bids

-(void)bidsList:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager GET:@"bids/"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                             NSLog(@"%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
}


-(void)bidsDetail:(NSString *)idTable onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    NSString * strBids = [NSString stringWithFormat:@"bids/?id=%@",idTable];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager GET:strBids
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                             NSLog(@"%@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"error%@",error);
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
    
}


#pragma mark updateUser/


- (void)updateUser:(NSString *)birth_date
                    cityId:(NSString *)cityId
                    sex:(NSString *)sex
                    name:(NSString *)name
                    onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                                birth_date, @"birth_date",
                                cityId, @"city_id",
                                sex, @"sex",
                                name ,@"name",
                                nil];
    
    
    NSLog(@"%@", [self getToken]);
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager POST:@"updateUser/"
                  parameters:params
                    progress:nil
                     success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                         
                         if(success){
                             success(responseObject);
                             NSLog(@"responce object %@",responseObject);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"error%@",operation);
                         
                         
                         
                         if(failure){
                             NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                             failure(error, response.statusCode);
                         }
                     }];
    
                        
}

#pragma mark accept_bid

-(void)accept_bids:(NSString *)bid_id
         onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             bid_id, @"id",
                             @"1", @"accept_bid",
                             nil];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager POST:@"bids/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if(success){
                              success(responseObject);
                              NSLog(@"responce object %@",responseObject);
                          }
                      }
                      failure:^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"error%@",operation);
                          
                          
                          
                          if(failure){
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
    
}

-(void)cancel_bid:(NSString *)bid_id onSuccess:(void (^)(NSDictionary *))success onFailure:(void (^)(NSError *, NSInteger))failure{
    
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             bid_id, @"id",
                             @"1", @"cancel_bid",
                             nil];
    
    [self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
    [self.sessionManager POST:@"bids/"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, NSDictionary*  responseObject) {
                          
                          if(success){
                              success(responseObject);
                              NSLog(@"responce object %@",responseObject);
                          }
                      }
                      failure:^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"error%@",operation);
                          if(failure){
                              NSHTTPURLResponse *response = (NSHTTPURLResponse *)operation.response;
                              failure(error, response.statusCode);
                          }
                      }];
}


@end
