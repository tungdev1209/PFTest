//
//  PFDataHandler.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/12/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFUser.h"

@protocol PFDataHandlerDelegate <NSObject>

-(void)PFDataRequestComplete:(id)results;

@end

@interface PFDataHandler : NSObject

@property (nonatomic, weak) id<PFDataHandlerDelegate> delegate;

-(instancetype)initWithDelegate:(id<NSObject>)delegate;
-(void)checkLoginState:(id<PFDataHandlerDelegate>)sender;
-(void)getUsers:(void(^)(NSArray *users))completion;
-(void)signupUser:(PFUser *)newUser completion:(void (^)(BOOL success))completion;
-(void)login:(PFUser *)user completion:(void (^)(PFUser *currentUser))completion;

@end
