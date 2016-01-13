//
//  PFHomeUsers.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFHomeUsersViewController.h"
#import "PFUserCellTableViewCell.h"

@interface PFHomeUsersViewController () <UITableViewDataSource, UITableViewDelegate, SlideNavigationContorllerAnimator, SlideNavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tblUsers;

@end

@implementation PFHomeUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tblUsers = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tblUsers.dataSource = self;
    _tblUsers.delegate = self;
}

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(PFUser *)userForIndexPath:(NSIndexPath*)indexPath{
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PFUserCellTableViewCell *cell = (PFUserCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    
    if (!cell) {
        cell = [[PFUserCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserCell"];
    }
    
    cell.user = [self userForIndexPath:indexPath];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
