//
//  PFUserCell.h
//  PFDemo
//
//  Created by Tung Nguyen on 1/18/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFUserCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatar;

-(void)loadUser:(PFUser*)user;

@end
