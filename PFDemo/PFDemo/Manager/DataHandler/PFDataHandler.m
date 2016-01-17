//
//  PFDataHandler.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFDataHandler.h"

@interface PFDataHandler () <NSURLSessionDelegate>

@property (nonatomic, strong) NSMutableArray *loginSenders;
@property (nonatomic, copy) NSString *token;

@end

@implementation PFDataHandler

-(instancetype)initWithDelegate:(id<PFDataHandlerDelegate>)delegate{
    if (self = [super init]) {
        [self checkLoginState:delegate];
    }
    return self;
}

-(void)checkLoginState:(id<PFDataHandlerDelegate>)sender{
    if (!_loginSenders) {
        _loginSenders = [NSMutableArray array];
    }
    
    [_loginSenders addObject:sender];
    
    if (_loginSenders.count > 1) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1.0f];
        for (id<PFDataHandlerDelegate> sender in _loginSenders) {
            [sender PFDataRequestComplete:@(NO)];
        }
    });
}

-(void)signupUser:(PFUser *)newUser completion:(void (^)(BOOL success))completion{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.255.201.10:9000/create"]];
    [request setHTTPMethod:@"POST"];
    NSDictionary *postDict = @{@"name":newUser.username,
                               @"email":newUser.email,
                               @"password":newUser.password};
    NSData *postData = [self encodeDictionary:postDict];
    [request setHTTPBody:postData];
    
    NSError *error = nil;
    [self doRequest:request completion:^(NSData *data) {
        NSError *parseError;
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&parseError];
            completion(YES);
        }
        else{
            completion(NO);
        }
    } error:&error];
}

-(void)login:(PFUser *)user completion:(void (^)(PFUser *currentUser))completion{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.255.201.10:9000/auth/signin"]];
    [request setHTTPMethod:@"POST"];
    NSDictionary *postDict = @{@"email":user.email,
                               @"password":user.password};
    NSData *postData = [self encodeDictionary:postDict];
    [request setHTTPBody:postData];
    
    NSError *error = nil;
    [self doRequest:request completion:^(NSData *data) {
        NSError *parseError;
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&parseError];
            PFUser *userLoggedIn = [[PFUser alloc]init];
            userLoggedIn.dataSource = json[@"user"];
            _token = json[@"token"];
            completion(userLoggedIn);
        }
        else{
            completion(nil);
        }
    } error:&error];
}

-(void)getUsers:(void(^)(NSArray *users))completion{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://54.255.201.10:9000/users"]];
    [request setHTTPMethod:@"GET"];
    
    NSDictionary *postDict = @{@"Authorization":[NSString stringWithFormat:@"m %@", _token]};
    NSData *postData = [self encodeDictionary:postDict];
    [request setHTTPBody:postData];
    
    NSError *error = nil;
    [self doRequest:request completion:^(NSData *data) {
        NSError *parseError;
        if (data) {
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&parseError];
            completion(json);
        }
        else{
            completion(nil);
        }
    } error:&error];
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

-(void)doRequest:(NSURLRequest*)request completion:(void (^)(NSData *data))completion error:(NSError **)resError{
    //Create session configuration
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Create url session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    
    //Create data task
    NSURLSessionTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        *resError = error;
        completion(data);
        [session finishTasksAndInvalidate];
    }];
    
    //Start task
    [sessionDataTask resume];
}

@end
