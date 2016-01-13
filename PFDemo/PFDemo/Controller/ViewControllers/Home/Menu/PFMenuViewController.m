//
//  PFMenuViewController.m
//  PFDemo
//
//  Created by Tung Nguyen on 1/13/16.
//  Copyright © 2016 Tung Nguyen. All rights reserved.
//

#import "PFMenuViewController.h"
#import "PFAboutViewController.h"
#import "PFHomeRootViewController.h"

@interface PFMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tbl;
@property (nonatomic, strong) NSArray *subMenus;

@end

@implementation PFMenuViewController

+(NSString *)className{
    return @"PFMenuViewController";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    _subMenus = @[@"Main", @"About"];
}

-(void)viewWillAppear:(BOOL)animated{
    _tbl.dataSource = self;
    _tbl.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnLogOutPressed:(id)sender{
    
}

-(NSString*)titleForIndexPath:(NSIndexPath*)indexPath{
    return _subMenus[indexPath.row];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _subMenus.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [self titleForIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [_AppCoreViewController switchToViewController:[PFHomeRootViewController className]];
    }
    else if (indexPath.row == 1) {
        [_AppCoreViewController switchToViewController:[PFAboutViewController className]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
