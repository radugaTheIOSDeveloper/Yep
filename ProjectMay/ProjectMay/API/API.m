//
//  API.m
//  Yep
//
//  Created by User on 12.05.2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

#import "API.h"

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

-(void) confirmOnetimePass:(NSString *)numPhone
                      onetime_pass:(NSString *)onetime_pass
                 onSuccess:(void(^)(NSDictionary * responseObject)) success
                 onFailure:(void(^)(NSError * error, NSInteger statusCode)) failure{
    
    NSDictionary * params = [NSDictionary dictionaryWithObjectsAndKeys:
                             numPhone, @"phone",
                             onetime_pass, @"onetime_pass",nil];
    
    
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
    
    //[self.sessionManager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"Authorization"];
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

@end
