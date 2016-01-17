//
//  PFHomeUsersView.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/16/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFHomeUsersView.h"

@interface PFHomeUsersView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tblUsers;

@end

@implementation PFHomeUsersView

-(void)loadView{
//    _tblUsers = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
//    _tblUsers.delegate = self;
//    _tblUsers.dataSource = self;
}

#pragma mark - UITableView Delegate & DataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
