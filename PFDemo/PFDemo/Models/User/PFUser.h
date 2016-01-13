//
//  PFUser.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFModelBase.h"

@interface PFUser : PFModelBase

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

@property (nonatomic, strong) NSDictionary *dataSource;

@end
