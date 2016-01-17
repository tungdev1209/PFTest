//
//  PFUser.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFUser.h"

@implementation PFUser

-(NSString *)imageURL{
    return _dataSource[@"avatar"];
}

-(NSString *)username{
    return _dataSource[@"name"];
}

@end
