//
//  PFHomeUsersView.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/16/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFHomeUsersView.h"
#import "PFUserCell.h"

@interface PFHomeUsersView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tblUsers;
@property (nonatomic, strong) NSArray *arrUsers;

@end

@implementation PFHomeUsersView

-(void)loadView{
    _tblUsers = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tblUsers.delegate = self;
    _tblUsers.dataSource = self;
    
    [self addSubview:_tblUsers];
    
    [_AppDataHandler getUsers:^(NSArray *users) {
        _arrUsers = users;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tblUsers reloadData];
        });
    }];
}

#pragma mark - UITableView Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrUsers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PFUserCell *cell = (PFUserCell*)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (!cell) {
        cell = [[PFUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
    }
    
    [cell loadUser:_arrUsers[indexPath.row]];
    
    NSURL *url = [NSURL URLWithString:[(PFUser*)_arrUsers[indexPath.row] imageURL]];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    PFUserCell *updateCell = (PFUserCell*)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.avatar.image = image;
                });
            }
        }
    }];
    [task resume];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
