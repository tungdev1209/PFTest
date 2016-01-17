//
//  PFUserCell.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/18/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFUserCell.h"

@implementation PFUserCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadUser:(PFUser *)user{
    _avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
    [self.contentView addSubview:_avatar];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
